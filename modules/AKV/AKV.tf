provider "azurerm" {
  features {
   
  }
  
}


data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "AKV" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard" 
  soft_delete_retention_days = 7
 # purge_protection_enabled = false



  
   

  access_policy {
     tenant_id = data.azurerm_client_config.current.tenant_id
     object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
      "Delete",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
     # "Purge",
      "Recover"
    ]
  }

}


data "azuread_service_principal" "example-app" {
  display_name = "example-app"

  # az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/dc272485-d2da-4a98-8171-00ce402c7324" --name example-app
}

// data "azurerm_subscription" "primary" {
// }

// resource "azurerm_role_assignment" "ara" {
//   scope                            = azurerm_key_vault.AKV.id       #data.azurerm_subscription.primary.id  
//   role_definition_name             = "Contributor"
//   principal_id                     = data.azuread_service_principal.example-app.object_id
//   skip_service_principal_aad_check = true
//   depends_on = [azurerm_key_vault.AKV]
// }


// resource "azurerm_key_vault_access_policy" "example-app-principal" {
//   key_vault_id = azurerm_key_vault.AKV.id
//   tenant_id    = data.azurerm_client_config.current.tenant_id
//   object_id    = data.azuread_service_principal.example-app.object_id
//   depends_on = [azurerm_key_vault.AKV ] #azurerm_role_assignment.ara
//   key_permissions = [
//     "Get", "List", "Encrypt", "Decrypt", "Delete"
//   ]

//   secret_permissions = [
//       "Set",
//       "Get",
//       "Delete",
//      # "Purge",
//       "Recover",
//       "List"
//     ]

   
// }


// resource "azurerm_role_assignment" "ara2" {
//   scope                = azurerm_key_vault.AKV.id   #data.azurerm_subscription.primary.id     
//   role_definition_name = "Contributor"
//   principal_id         = var.principal_id  # azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
    
//   skip_service_principal_aad_check = true
//   depends_on = [azurerm_key_vault.AKV]
// }

// resource "azurerm_key_vault_access_policy" "AKS-Agentpool-principal" {
//   key_vault_id = azurerm_key_vault.AKV.id
//   tenant_id    = data.azurerm_client_config.current.tenant_id
//   object_id    = var.object_id   # azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
//   depends_on = [azurerm_key_vault.AKV]
//   key_permissions = [
//     "Get", "List", "Encrypt", "Decrypt", "Delete"
//   ] 

//   secret_permissions = [
//     "Set",
//     "Get",
//     "Delete",
//   #  "Purge",
//     "Recover",
//     "List"
//   ]

  
// } 

// resource "tls_private_key" "main" {
//   algorithm = "RSA"
//   rsa_bits  = 2048
// }

resource "azurerm_key_vault_secret" "secret1" {
  name         = "username"
  value        = var.user_name  #"amankusalkar"                  #tls_private_key.main.private_key_pem
  key_vault_id = azurerm_key_vault.AKV.id
  depends_on   = [azurerm_key_vault.AKV]
}

resource "azurerm_key_vault_secret" "secret2" {
  name         = "user-password"
  value        =  var.user_password   #"Banglore#1995"                          #tls_private_key.main.private_key_pem
  key_vault_id = azurerm_key_vault.AKV.id
  #depends_on   = [azurerm_key_vault.AKV]
  depends_on   = [azurerm_key_vault.AKV]
}

resource "azurerm_key_vault_secret" "secret3" {
  name         = "root-password"
  value        =  var.user_rootpassword  #"Maharashtra1995@"                                #tls_private_key.main.private_key_pem
  key_vault_id = azurerm_key_vault.AKV.id
  #depends_on   = [azurerm_key_vault.AKV]
  depends_on   = [azurerm_key_vault.AKV]
}

// resource "azurerm_key_vault_secret" "secret4" {
//   name         = "d-password"
//   value        = tls_private_key.main.private_key_pem
//   key_vault_id = azurerm_key_vault.AKV.id
//   depends_on   = [azurerm_key_vault.AKV]

// }