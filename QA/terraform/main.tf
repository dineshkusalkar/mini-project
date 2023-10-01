# Keep the terraform state file at a centralised location
# here i created storage account manually and provide details in backend block
terraform {
  backend "azurerm" {
    resource_group_name  = "backend-statefile"
    storage_account_name = "terraformstate1998"
    container_name       = "backend"
    key                  = "terraform-qa.tfstate"

  }
}

// terraform {
//   required_providers {
//     tls = {
//       source  = "hashicorp/tls"
//       version = "~> 4.0.4"
//     }
//   }
// }

provider "azurerm" {
  features {
    
  }
  
}



module "RG"{
    source =  "../../modules/RG/"      
    resource_group_name = var.resource_group_name
    location = var.location
  
}

// module "AKS"{
//     source =  "../../modules/AKS/"      
//     resource_group_name = module.RG.resource_group_name
//     cluster_name = var.cluster_name
  
// }



module "AKV"{
    source = "../../modules/AKV/"      
    name = var.name
    # cluster_name = var.cluster_name
    resource_group_name = module.RG.resource_group_name
   # principal_id = module.AKS.kubelet_identity_object_id
   # object_id = module.AKS.kubelet_identity_object_id
 
   

}



// output "kubelet_identity_client_id" {
//   value = module.AKS.kubelet_identity_client_id
  
// }