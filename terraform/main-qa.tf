# Keep the terraform state file at a centralised location
# here i created storage account manually and provide details in backend block
terraform {
  backend "azurerm" {
    resource_group_name  = "backend-statefile"
    storage_account_name = "terraformstate1998"
    container_name       = "backend"
    key                  = "terraform-prod.tfstate"

  }
}


provider "azurerm" {
  features {}
}



module "AKS"{
    source = "../modules/AKS/"
    resource_group_name = "mini-project-PROD"
    cluster_name = "AKS-PROD"
  
}



module "AKV"{
    source = "../modules/AKV/"
    name = "kvdinesh007-PROD"
    resource_group_name = module.AKS.resource_group_name
    principal_id = module.AKS.kubelet_identity_object_id
    object_id = module.AKS.kubelet_identity_object_id

}



output "kubelet_identity_client_id" {
  value = module.AKS.kubelet_identity_client_id
  
}