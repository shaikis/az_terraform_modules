resource "azurerm_sql_database" "azsql_dedicated_db" {
  count               = var.enable_dedicated_db ? 1: 0
  name                = var.mssql_db_name
  resource_group_name = var.mssql_resource_groupname
  location            = var.mssql_resource_location
  server_name         = var.ms_sqlserver_name

  extended_auditing_policy {
    storage_endpoint                        = var.az_storage_primary_blob_endpoint
    storage_account_access_key              = var.az_storage_primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = var.audit_logs_retention_days
  }

  tags = {
    environment = var.env
  }

}
resource "azurerm_mssql_database" "serverless_db" {
    count                       = var.enable_serverless_db ? 1: 0
    name                        = var.mssql_db_name
    server_id                   = var.ms_sqlserver_id
    collation                   = var.sql_server_db_collection  #"SQL_Latin1_General_CP1_CI_AS"

    auto_pause_delay_in_minutes = var.auto_pause_delay  #60
    max_size_gb                 = var.max_db_size       #30g
    min_capacity                = var.min_capacity_db   #0.5
    read_replica_count          = var.read_replica_count #0
    read_scale                  = var.ms_serverless_read_scale # false
    sku_name                    = var.ms_serverless_sku_name #"GP_S_Gen5_1"
    zone_redundant              = var.ms_serverless_zone_redundant #false

    threat_detection_policy {
        disabled_alerts      = []
        email_account_admins = "Disabled"
        email_addresses      = []
        retention_days       = 0
        state                = "Disabled"
        use_server_default   = "Disabled"
    }
}