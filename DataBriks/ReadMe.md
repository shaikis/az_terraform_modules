# Use of this module.

```
module "DataBricks" {
#    source = git@github.com:shaikis/az_terraform_modules.git  # if you copied this as a seperate repo in your org.
    source = ./DataBriks
    resource_groupname = var.resource_group_name (or) module.groups.resource_group_name
    resource_location = "Uk South"
    env               = "prod"
    ARM_CLIENT_SECRET = "random password which is generated using terraform random function"
    databricks_cluster_name = var.data_bricks_cluster_name
    bricks_mount_vol_name  = var.mount_vol_name  # this mount point created in data bricks cluster.


}
```


# Input Variables. 
- `resource_groupname` - Resource group details where you wants to configure Databricks resources.
- `resource_location`  - Location of the resources for example 'UK South', 'Westeurope' ..etc
- `env`                - Name of the environment`
- `ARM_CLIENT_SECRET`  - Secret details to create service principl, and this service principal used to mount the storage in DataBricks.
- `databricks_cluster_name` - Cluster name of the DataBricks

