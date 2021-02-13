resource "azurerm_storage_account" "az_storage" {
  name                     = var.project_name - var.env - var.storage_name
  resource_group_name      = var.rg_name
  location                 = var.loc
  account_tier             = var.storage_account_tier
  account_replication_type = "LRS"
}
