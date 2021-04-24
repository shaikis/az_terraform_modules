# Usage of this module. 

```
module "ad_service_principal_creation" {
    source = "./azure_service_principal"
    az_application_name = var.name_of_application

}
```
### Mandatory variables
- `az_application_name`  - service principal name of the application.
