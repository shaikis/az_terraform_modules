provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.databricks_workspace.id
}