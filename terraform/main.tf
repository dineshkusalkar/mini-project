# Keep the terraform state file at a centralised location
# here i created storage account manually and provide details in backend block
terraform {
  backend "azurerm" {
    resource_group_name  = "backend-statefile"
    storage_account_name = "terraformstate1998"
    container_name       = "backend"
    key                  = "terraform.tfstate"

  }
}


provider "azurerm" {
  features {}
}



module "AKS"{
    source = "../modules/AKS/"
    resource_group_name = "mini-project-QA"
    cluster_name = "AKS-QA"
   

    # output "kubelet_identity_object_id" {
    #   description = "The `azurerm_kubernetes_cluster`'s `kubelet_identity` block."
    #   value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
    # }
}



module "AKV"{
    source = "../modules/AKV/"
    name = "kvdinesh007-QA"
    resource_group_name = module.AKS.resource_group_name
    principal_id = module.AKS.kubelet_identity_object_id
    object_id = module.AKS.kubelet_identity_object_id

}


