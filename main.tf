#create terraform statefile storage and vault, this is required only one time. later disable this.
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

#this module depends on Users_and_groups , Monitoring_Security
module "key-vault" {
  source  = "./keyvault"
  resource_group_name        = module.users_and_groups.audit_rg_name
  key_vault_name             = "devops-project-shard"
  key_vault_sku_pricing_tier = "premium"
  enable_purge_protection = false
  enable_soft_delete      = false
  # Adding Key valut logs to Azure monitoring and Log Analytics space
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.storage_account_id
  # Access policies for users, you can provide list of Azure AD users and set permissions.
  # Make sure to use list of user principal names of Azure AD users.
  access_policies = [
    {
      azure_ad_user_principal_names = ["user1@example.com", "user2@example.com"]
      key_permissions               = ["get", "list"]
      secret_permissions            = ["get", "list"]
      certificate_permissions       = ["get", "import", "list"]
      storage_permissions           = ["backup", "get", "list", "recover"]
    },

    # Access policies for AD Groups, enable this feature to provide list of Azure AD groups and set permissions.
    {
      azure_ad_group_names = ["ADGroupName1", "ADGroupName2"]
      secret_permissions   = ["get", "list", "set"]
    },
  ]
  # Create a required Secrets as per your need.
  # When you Add `usernames` with empty password this module creates a strong random password 
  # use .tfvars file to manage the secrets as variables to avoid security issues. 
  secrets = {
    "message" = "Hello, world!"
    "vmpass"  = ""
  }

  # Adding TAG's to your Azure resources (Required)
  # ProjectName and Env are already declared above, to use them here or create a varible. 
  tags = {
    ProjectName  = "demo-project"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
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
   
   containers_list = [
    { name = "default", access_type = "container" }
  ]

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



terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraformstate"
    storage_account_name = "hallo-dev-tfstate"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}