resource "azurerm_storage_account" "audit_storage" {
  name                     = var.project_name - var.env - var.storage_name
  resource_group_name      = var.rg_name
  location                 = var.loc
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
