##Usage of this module. 

```
module "datalake_storage" {
    source = "./storage/datalake
    datalake_storage_rg_anme          = module.Resource_groups.rg_name
    datalake_storage_location         = "UK South"
    datalake_storage_account_tier     = "standard"
    datalake_storage_account_kind     = "StorageV2"
    datalake_storage_name             = "az-learning"
    datalake_filesystem_name           = ["raw", "cleansed"]
# Grant access on storage to dataFactory/Service Principal/objectId.
    role_definition_name              = "owner"
    object_principal_id               = ["object Id1", "Service Principal id", "Datafactory Managed Identity...etc"]

}
```

### Mandatory input variables.
- `datalake_storage_rg_anme` - resource group name where you wants to create this datalake storage.         
-    `datalake_storage_location`  - storage Location ex: "UK South"/West Europe        
-    `datalake_storage_account_tier`    - Standard/Premimum..etc
-    `datalake_storage_account_kind`    - storageV1/V2
-    `datalake_storage_name`            - Storage account name , all case sensitive, no special charactors.
-    `datalake_filesystem_name`         -  File systems/containers.
##### Grant access on storage to dataFactrvice Principal/objectId.
-    `role_definition_name`             - role definition like  owner/contributor/ storage blob contributor..etc   
-    `object_principal_id`              - object id of azure resource to whom you want to grant the access. 
