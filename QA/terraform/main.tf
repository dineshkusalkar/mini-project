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
    source = "mini-project/modules/AKS/"
    resource_group_name = "mini-project-QA"
    cluster_name = "AKS-QA"


}

module "AKV"{
    source = "mini-project/modules/AKV/"
    name = "kvdinesh007-QA"
    resource_group_name = "mini-project-QA"

}


module "secrets"{
    source = "mini-project/modules/secrets/"
    
}