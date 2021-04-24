output "project_rg_name" {
   value = azurerm_resource_group.resourcegroup[0].name
}

output "audit_rg_name" {
   value = azurerm_resource_group.resourcegroup[1].name
}