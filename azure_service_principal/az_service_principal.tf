# Create application.
resource "azuread_application" "az_application" {
  name = var.az_application_name
}

# Create service principal
resource "azuread_service_principal" "service_principal" {
  application_id               = azuread_application.az_application.application_id
  app_role_assignment_required = false
}

# generate random password
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azuread_service_principal_password" "service_principal_password" {
  service_principal_id = azuread_service_principal.service_principal.id
  description          = "My managed password"
  value                = random_password.password.result
  end_date             = "2099-01-01T01:02:03Z"
}