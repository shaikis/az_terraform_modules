locals {
  role_df_name = var.role_definition_name
  object_id    = var.object_principal_id
}


resource "azurerm_role_assignment" "datalake_access" {
  count                = length(local.object_id)
  scope                = azurerm_storage_account.datalake_storage.id

  trigger {    
  role_definition_name = local.role_df_name
  principal_id         = element(local.object_id, count.index)
  }
}
