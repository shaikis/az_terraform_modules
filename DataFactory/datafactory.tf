resource "azurerm_data_factory" "data_factory" {
  name                = var.df_name
  location            = var.location
  resource_group_name = var.rg_name
  
    identity {
    type = "SystemAssigned"
  }
  
}

data "azurerm_storage_account" "storage_account" {
  name                = var.storage_account_name
  resource_group_name = var.rg_name
}

data "azurerm_subscription" "current" {}

data "azurerm_builtin_role_definition" "contributor" {
  name = "Contributor"
}

resource "azurerm_role_assignment" "main" {
  scope                = data.azurerm_storage_account.storage_account.id
  role_definition_name = data.azurerm_builtin_role_definition.contributor
  principal_id         = azurerm_data_factory.data_factory.identity.0.principal_id
}


resource "azurerm_data_factory_linked_service_azure_blob_storage" "linked_service_name" {
  name                = "storage-Linked-service"
  resource_group_name = var.rg_name
  data_factory_name   = azurerm_data_factory.data_factory.name
  use_managed_identity   = data.azurerm_storage_account.storage_account.dentity.0.principal_id

}
