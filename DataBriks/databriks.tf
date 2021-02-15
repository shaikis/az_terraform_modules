resource "azurerm_databricks_workspace" "example" {
  name                = "databricks-test"
  resource_group_name = var.resource_groupname
  location            = var.resource_location
  sku                 = "standard"

  tags = {
    Environment = var.env
  }
}