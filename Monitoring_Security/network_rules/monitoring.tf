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