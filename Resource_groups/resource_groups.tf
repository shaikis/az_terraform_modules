resource "azurerm_resource_group" "resourcegroup" {
  count  = length(var.resource_group_name)
  name     = element(var.resource_group_name, count.index)
  location = var.location_name
}
