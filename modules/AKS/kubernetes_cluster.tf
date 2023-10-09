resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name


  default_node_pool {
    name       = "system"
    node_count = var.system_node_count
    vm_size    = var.vm_size
    type       = var.vm_type

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

 output "kubelet_identity_object_id" {
      description = "The `azurerm_kubernetes_cluster`'s `kubelet_identity` block."
      value       = azurerm_kubernetes_cluster.kubernetes_cluster.kubelet_identity[0].object_id
    }


output "kubelet_identity_client_id" {
  description = "The `azurerm_kubernetes_cluster`'s `kubelet_identity` block."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.kubelet_identity[0].client_id
}

