## we need tfstate resource group and  tfstate storage account and container.
#
##create AD users,groups and mandatory Resource groups
#module "users_and_groups" {
#    source = "./Users_groups"
#    resource_group_name = "hello_x"
#    location_name       = "west europe"
#    resource_group_audit = "hello_x_audit"
#    
#}
#
## Storage account created as projectname-env-audit/hello/xyz"
#module "tfstate_storage" {
#   source = "./storage/standard"
#   project_name = "hello-x"
#   env          = "dev"
#   storage_name = "tfstate"
#   loc          = "west europe"
#   rg_name      = module.users_and_groups.resource_group_name
#}

