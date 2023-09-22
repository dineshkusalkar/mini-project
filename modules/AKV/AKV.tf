


data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "AKV" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.mini-project.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard" 
  soft_delete_retention_days = 7



  
  depends_on = [azurerm_kubernetes_cluster.aks]

  access_policy {
     tenant_id = data.azurerm_client_config.current.tenant_id
     object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }

}


data "azuread_service_principal" "example-app" {
  display_name = "example-app"

  # az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/dc272485-d2da-4a98-8171-00ce402c7324" --name example-app
}

resource "azurerm_role_assignment" "ara" {
  scope                            = azurerm_key_vault.AKV.id
  role_definition_name             = "Contributor"
  principal_id                     = data.azuread_service_principal.example-app.object_id
  skip_service_principal_aad_check = true
  depends_on = [azurerm_key_vault.AKV]
}


resource "azurerm_key_vault_access_policy" "example-app-principal" {
  key_vault_id = azurerm_key_vault.AKV.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.example-app.object_id
  depends_on = [azurerm_key_vault.AKV]
  key_permissions = [
    "Get", "List", "Encrypt", "Decrypt", "Delete"
  ]

  secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]

   
}


resource "azurerm_role_assignment" "ara2" {
  scope                = azurerm_key_vault.AKV.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
  depends_on = [azurerm_key_vault.AKV]
}

resource "azurerm_key_vault_access_policy" "AKS-Agentpool-principal" {
  key_vault_id = azurerm_key_vault.AKV.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id 
  depends_on = [azurerm_key_vault.AKV]
  key_permissions = [
    "Get", "List", "Encrypt", "Decrypt", "Delete"
  ] 

  secret_permissions = [
    "Set",
    "Get",
    "Delete",
    "Purge",
    "Recover",
    "List"
  ]

  
} 

