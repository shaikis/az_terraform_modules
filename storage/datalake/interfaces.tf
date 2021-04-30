  variable "datalake_storage_rg_anme" {}
  variable "datalake_storage_location" {}
  variable "datalake_storage_account_tier" {}
  variable "datalake_storage_account_kind" {}
  variable "datalake_storage_name" {}
  variable "datalake_filesystem_name" {
    type = list
  }

variable "object_principal_id" {
  type = list
}
variable "role_definition_name" {}