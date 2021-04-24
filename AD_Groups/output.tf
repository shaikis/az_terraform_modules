output "ad_group_names" {
    value = toset([
    for bd in azuread_group.azure_ad_groups : azure_ad_groups.name
  ])
}