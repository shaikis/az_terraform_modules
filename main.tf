#create terraform statefile storage and vault, this is required only one time. later disable this.
module "init_backend" {
    source = "./initBackend"
    
}

#create AD users,groups and mandatory Resource groups
module "users_and_groups" {
    source = "./Users_groups"
    resource_group_name = "hello_x"
    location_name       = "west europe"
    resource_group_audit = "hello_x_audit"
    
}

# Storage account created as projectname-env-audit/hello/xyz"
module "audit_storage" {
   source = "./storage/standard"
   project_name = "hello-x"
   env          = "dev"
   storage_name = "audit"
   loc          = "west europe"
   rg_name      = module.users_and_groups.audit_rg_name
}

#Create sql server
module "sqlserver" {
    source = "./SQL_servers/MSsql"
    mssql_server_name                   = "hellosqlserver"
    rgroup_name                         = module.users_and_groups.project_rg_name
    loc_name                            = "West europe"
    sqlserver_version                   = "12.0"
    admin_login_name                    = data.get_vault_data.sql_admin_user_name
    admin_password                      = data.get_vault_data.sql_admin_user_pass
    audit_storage_primary_blob_endpoint = module.audit_storage.audit_storage_primary_blob_endpoint
    audit_storage_primary_access_key    = module.audit_storage.audit_storage_primary_access_key

    
}

