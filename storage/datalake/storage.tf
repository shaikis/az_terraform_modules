resource "azurerm_storage_account" "datalake_storage" {
  name                     = var.datalake_storage_name
  resource_group_name      = var.datalake_storage_rg_anme
  location                 = var.var.datalake_storage_location
  account_tier             = var.datalake_storage_account_tier
  account_replication_type = "LRS"
  account_kind             = var.datalake_storage_account_kind
  is_hns_enabled           = "true"
}