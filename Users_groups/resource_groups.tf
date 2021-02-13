resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resource_group_name
  location = var.location_name
}

resource "azurerm_resource_group" "resourcegroup_audit" {
  name     = var.resource_group_audit
  location = var.location_name
}