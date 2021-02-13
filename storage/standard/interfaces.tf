variable "loc" {}
variable "rg_name" { }
variable "project_name" {}
variable "env" { }
variable "storage_name" { }
variable "containers_list" {
  description = "List of containers to create and their access levels."
  type        = list(object({ name = string, access_type = string }))
  default     = []
}

variable "storage_account_tier" {}