data "azurerm_client_config" "current" {}

data "azuread_group" "adgrp" {
  count = length(local.azure_ad_group_names)
  name  = local.azure_ad_group_names[count.index]
}

data "azuread_user" "adusr" {
  count               = length(local.azure_ad_user_principal_names)
  user_principal_name = local.azure_ad_user_principal_names[count.index]
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_key_vault" "main" {
  name                            = lower("kv-${var.key_vault_name}")
  location                        = data.azurerm_resource_group.rg.location
  resource_group_name             = data.azurerm_resource_group.rg.name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.key_vault_sku_pricing_tier
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  soft_delete_enabled             = var.enable_soft_delete
  purge_protection_enabled        = var.enable_purge_protection

  tags = merge({ "ResourceName" = lower("kv-${var.key_vault_name}") }, var.tags, )

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [true] : []
    content {
      bypass                     = var.network_acls.bypass
      default_action             = var.network_acls.default_action
      ip_rules                   = var.network_acls.ip_rules
      virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
    }
  }

  dynamic "access_policy" {
    for_each = local.combined_access_policies
    content {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = access_policy.value.object_id
      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      storage_permissions     = access_policy.value.storage_permissions
    }
  }
  dynamic "access_policy" {
    for_each = local.service_principal_object_id != "" ? [local.self_permissions] : []
    content {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = access_policy.value.object_id
      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      storage_permissions     = access_policy.value.storage_permissions
    }
  }
}

resource "random_password" "passwd" {
  for_each    = var.secrets
  length      = 24
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  min_special = 4

  keepers = {
    name = each.key
  }
}

resource "azurerm_key_vault_secret" "keys" {
  for_each     = var.secrets
  name         = each.key
  value        = each.value != "" ? each.value : random_password.passwd[each.key].result
  key_vault_id = azurerm_key_vault.main.id
}

resource "azurerm_monitor_diagnostic_setting" "diag" {
  count                          = var.log_analytics_workspace_id != null ? 1 : 0
  name                           = format("%s-analytics", azurerm_key_vault.main.name)
  target_resource_id             = azurerm_key_vault.main.id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = "Dedicated"
  storage_account_id             = var.storage_account_id
  log {
    category = "AuditEvent"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}