resource "azuread_group" "azure_ad_groups" {
    count = length(var.ad_group_names)
    name = element(var.ad_group_names, count.index)
}