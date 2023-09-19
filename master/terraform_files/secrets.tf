resource "azurerm_key_vault_secret" "secrets1" {
  name         = "username"
  value        = "dinesh"
  key_vault_id = azurerm_key_vault.AKV.id
  depends_on   = [azurerm_key_vault.AKV]

}

resource "azurerm_key_vault_secret" "secrets2" {
  name         = "user-password"
  value        = "Banglore#1998"
  key_vault_id = azurerm_key_vault.AKV.id
  depends_on   = [azurerm_key_vault.AKV]

}

resource "azurerm_key_vault_secret" "secrets3" {
  name         = "root-password"
  value        = "Maharashtra1998@"
  key_vault_id = azurerm_key_vault.AKV.id
  depends_on   = [azurerm_key_vault.AKV]

}