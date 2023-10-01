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




resource "azurerm_role_assignment" "ara2" {
  scope                = azurerm_key_vault.AKV.id   #data.azurerm_subscription.primary.id     
  role_definition_name = "Contributor"
  principal_id         = var.principal_id  # azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
    
  skip_service_principal_aad_check = true
  depends_on = [azurerm_key_vault.AKV]
}

resource "azurerm_key_vault_access_policy" "AKS-Agentpool-principal" {
  key_vault_id = azurerm_key_vault.AKV.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.object_id   # azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  depends_on = [azurerm_key_vault.AKV]
  

  secret_permissions = [
   
    "Get",
    
    "List"
  ]

  
} 



resource "azurerm_key_vault_secret" "secret1" {
  name         = "username"
  value        = "$(user_name)"
  key_vault_id = azurerm_key_vault.AKV.id
  depends_on   = [azurerm_key_vault.AKV]
}

resource "azurerm_key_vault_secret" "secret2" {
  name         = "user-password"
  value        = "$(user_password)"
  key_vault_id = azurerm_key_vault.AKV.id
  depends_on   = [azurerm_key_vault.AKV]
}

resource "azurerm_key_vault_secret" "secret3" {
  name         = "root-password"
  value        = "$(user_rootpassword)"
  key_vault_id = azurerm_key_vault.AKV.id
  #depends_on   = [azurerm_key_vault.AKV]
  depends_on   = [azurerm_key_vault.AKV]
}

