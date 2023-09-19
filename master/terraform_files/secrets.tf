resource "azurerm_key_vault_secret" "secret1" {
  name         = "username"
  value        = "dinesh"
  key_vault_id = azurerm_key_vault.AKV.id
  depends_on   = [azurerm_key_vault.AKV, azurerm_role_assignment.ara, azurerm_key_vault_access_policy.example-app-principal, azurerm_role_assignment.ara2, azurerm_key_vault_access_policy.AKS-Agentpool-principal]


}

resource "azurerm_key_vault_secret" "secret2" {
  name         = "user-password"
  value        = "Banglore#1998"
  key_vault_id = azurerm_key_vault.AKV.id
  depends_on   = [azurerm_key_vault.AKV, azurerm_role_assignment.ara, azurerm_key_vault_access_policy.example-app-principal, azurerm_role_assignment.ara2, azurerm_key_vault_access_policy.AKS-Agentpool-principal]


}

resource "azurerm_key_vault_secret" "secret3" {
  name         = "root-password"
  value        = "Maharashtra1998@"
  key_vault_id = azurerm_key_vault.AKV.id
  depends_on   = [azurerm_key_vault.AKV, azurerm_role_assignment.ara, azurerm_key_vault_access_policy.example-app-principal, azurerm_role_assignment.ara2, azurerm_key_vault_access_policy.AKS-Agentpool-principal]


}