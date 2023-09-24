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
  client_id       = "fbc85d1a-63e6-43b1-b528-35f30e561182"
  client_secret   = "56-8Q~fiieMS4OtiiCHRBAzXfQgrlaeq3wVTobA_"
  tenant_id       = "62c65783-e48b-4438-8d2a-50fb84685b6e"
  subscription_id = "dc272485-d2da-4a98-8171-00ce402c7324"
}



module "AKS"{
    source =  "../modules/AKS/"       #"../modules/AKS/"
    resource_group_name = "mini-project-QA"
    cluster_name = "AKS-QA"
  
}



module "AKV"{
    source = "./mini-project/modules/AKV"       #"../modules/AKV/"
    name = "kvdinesh007-QA"
    cluster_name = "AKS-QA"
    resource_group_name = module.AKS.resource_group_name
    principal_id = module.AKS.kubelet_identity_object_id
    object_id = module.AKS.kubelet_identity_object_id

}



output "kubelet_identity_client_id" {
  value = module.AKS.kubelet_identity_client_id
  
}