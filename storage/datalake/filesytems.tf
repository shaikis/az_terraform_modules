resource "azurerm_storage_data_lake_gen2_filesystem" "datalake_filesystem" {
  count              = length(var.datalake_filesystem_name)
  name               = element(var.datalake_filesystem_name, count.index)
  storage_account_id = azurerm_storage_account.datalake_storage.id
}