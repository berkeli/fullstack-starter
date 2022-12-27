resource "azurerm_app_service_custom_hostname_binding" "web" {
  hostname            = var.DOMAIN
  app_service_name    = azurerm_linux_web_app.web.name
  resource_group_name = data.azurerm_resource_group.this.name

  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
}

resource "azurerm_app_service_managed_certificate" "web" {
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.web.id
}

resource "azurerm_app_service_certificate_binding" "web" {
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.web.id
  certificate_id      = azurerm_app_service_managed_certificate.web.id
  ssl_state           = "SniEnabled"
}
