provider "azurerm" {
  features {
    /*  key_vault {
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets          = true
    } */
  }
    /* subscription_id = "dc272485-d2da-4a98-8171-00ce402c7324"
    client_id       = "a2f41ac3-5790-48ff-bd06-d95a93721bc1"
    client_secret   = "zdw8Q~Dim1UP6Ri9xkk1AtfZPKpupmHc0qHUNcTO"
    tenant_id       = "62c65783-e48b-4438-8d2a-50fb84685b6e" */ 

}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.71.0"
    }
  }
}