data "azurerm_client_config" "current" {}

resource "azurerm_sql_server" "mssqlserver" {
  name                         = var.mssql_server_name
  resource_group_name          = var.rgroup_name
  location                     = var.loc_name
  version                      = var.sqlserver_version
  administrator_login          = var.admin_login_name
  administrator_login_password = var.admin_password

  extended_auditing_policy {
    storage_endpoint                        = var.audit_storage_primary_blob_endpoint
    storage_account_access_key              = var.audit_storage_primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = {
    environment = var.env
  }
}

resource "azurerm_sql_active_directory_administrator" "sqlad_admin_login" {
  server_name         = azurerm_sql_server.mssqlserver.name
  resource_group_name = var.rgroup_name
  login               = "sqladmin"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
}