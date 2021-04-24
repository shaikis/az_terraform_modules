
resource "databricks_secret_scope" "terraform" {
    name                     = "application"
    initial_manage_principal = "users"
}

resource "databricks_secret" "service_principal_key" {
    key          = "service_principal_key"
    string_value = var.ARM_CLIENT_SECRET
    scope        = databricks_secret_scope.terraform.name
}

data "azurerm_client_config" "current" {
}


resource "databricks_azure_adls_gen2_mount" "marketing" {
    container_name         = azurerm_storage_container.databricks_workspace.name
    storage_account_name   = azurerm_storage_account.this.name
    mount_name             = var.bricks_mount_vol_name
    tenant_id              = data.azurerm_client_config.current.tenant_id
    client_id              = data.azurerm_client_config.current.client_id
    client_secret_scope    = databricks_secret_scope.terraform.name
    client_secret_key      = databricks_secret.service_principal_key.key
    initialize_file_system = true
}