output "project_rg_name" {
   value = azurerm_resource_group.resourcegroup.name
}

output "audit_rg_name" {
   value = azurerm_resource_group.resourcegroup_audit.name
}