# Keep the terraform state file at a centralised location
# here i created storage account manually and provide details in backend block
terraform {
  backend "azurerm" {
    resource_group_name  = "backend-statefile"
    storage_account_name = "terraformstate18"
    container_name       = "backend"
    key                  = "terraform-prod.tfstate"

  }
}


provider "azurerm" {
  features {}
  skip_provider_registration = true
}



module "AKS"{
    source =  "../../modules/AKS/"       
    resource_group_name = "$RESOURCE_GROUP"
    cluster_name = "AKS-QA"
  
}



module "AKV"{
    source = "../../modules/AKV/"       
    name = "kvdinesh007-QA"
    cluster_name = "AKS-QA"
    resource_group_name = module.AKS.resource_group_name
    principal_id = module.AKS.kubelet_identity_object_id
    object_id = module.AKS.kubelet_identity_object_id

}



output "kubelet_identity_client_id" {
  value = module.AKS.kubelet_identity_client_id
  
}