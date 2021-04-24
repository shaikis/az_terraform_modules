# usage of this module. 

```
module "azure_ad_groups" {
    source = ./AD_Groups
    ad_group_names = ["projectName-rw", "projectName-RO", "ProjectName-Contributor"]
}
```