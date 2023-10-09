resource "azurerm_resource_group" "mini-project" {
  name     = var.resource_group_name
  location = var.location

}


output "resource_group_name" {
  
  value       = azurerm_resource_group.mini-project.name
}