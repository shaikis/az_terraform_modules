output "audit_storage_primary_blob_endpoint" {
   value = azurerm_storage_account.audit_storage.primary_blob_endpoint
}
output "audit_storage_primary_access_key" {
   value = azurerm_storage_account.audit_storage.primary_access_key
}