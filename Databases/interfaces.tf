variable "az_storage_primary_blob_endpoint" {}
variable "az_storage_primary_access_key" {}
variable "mssql_db_name" {}
variable "ms_sqlserver_name" {}
variable "mssql_resource_groupname" {}
variable "mssql_resource_location" {}
variable "env" {}
variable "enable_dedicated_db" {}
variable "enable_serverless_db" {}
variable "sql_server_db_collection" {
  default     = "SQL_Latin1_General_CP1_CI_AS"
}
variable "auto_pause_delay" {
  default     = "60"
}
variable "max_db_size" {
  default     = "30"
}
variable "min_capacity_db" {
  default     = "0.5"
}
variable "read_replica_count" {
  default     = "0"
}
variable "ms_serverless_read_scale" {
  default     = "false"
}
variable "ms_serverless_sku_name" {
  default     = "GP_S_Gen5_1"
}
variable "ms_serverless_zone_redundant" {
  default     = "false"
}
variable "audit_logs_retention_days" {
  default     = "6"
}
