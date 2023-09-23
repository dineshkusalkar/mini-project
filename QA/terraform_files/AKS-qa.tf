resource "azurerm_resource_group" "mini-project-qa" {
  name     = "${var.resource_group_name}-QA"
  location = var.location

}



resource "azurerm_kubernetes_cluster" "aks-qa" {
  name                = "${var.cluster_name}-QA"
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.mini-project-qa.name
  dns_prefix          = var.cluster_name


  default_node_pool {
    name       = "system"
    node_count = var.system_node_count
    vm_size    = "Standard_DS2_v2"
    type       = "VirtualMachineScaleSets"

    zones               = [1, 2, 3]
    enable_auto_scaling = true
    max_count           = 10
    min_count           = 1

  }

  identity {
    type = "SystemAssigned"
  }


  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }


}

/*output "kubelet_identity_object_id" {
  description = "The `azurerm_kubernetes_cluster`'s `kubelet_identity` block."
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}*/


output "kubelet_identity_client_id" {
  description = "The `azurerm_kubernetes_cluster`'s `kubelet_identity` block."
  value       = azurerm_kubernetes_cluster.aks-qa.kubelet_identity[0].client_id
}

