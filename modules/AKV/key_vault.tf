data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "azure_key_vault" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard" 
  soft_delete_retention_days = 7

  access_policy {
     tenant_id = data.azurerm_client_config.current.tenant_id
     object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "List",
      "Purge",
      "Recover"
    ]
  }

}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = azurerm_key_vault.azure_key_vault.id        
  role_definition_name = "Contributor"
  principal_id         = var.principal_id  
    
  skip_service_principal_aad_check = true
  depends_on = [azurerm_key_vault.azure_key_vault]
}

resource "azurerm_key_vault_access_policy" "aks-agentpool" {
  key_vault_id = azurerm_key_vault.azure_key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.object_id   
  depends_on = [azurerm_key_vault.azure_key_vault]
  secret_permissions = [
   
    "Get",
    
    "List"
  ]

  
} 

resource "azurerm_key_vault_secret" "secret1" {
  name         = "username"
  value        = var.user_name
  key_vault_id = azurerm_key_vault.azure_key_vault.id
  depends_on   = [azurerm_key_vault.azure_key_vault]
}

resource "azurerm_key_vault_secret" "secret2" {
  name         = "user-password"
  value        = var.user_password
  key_vault_id = azurerm_key_vault.azure_key_vault.id
  depends_on   = [azurerm_key_vault.azure_key_vault]
}

resource "azurerm_key_vault_secret" "secret3" {
  name         = "root-password"
  value        = var.user_rootpassword
  key_vault_id = azurerm_key_vault.azure_key_vault.id
  depends_on   = [azurerm_key_vault.azure_key_vault]
}

