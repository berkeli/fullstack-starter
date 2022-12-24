resource "azurerm_service_plan" "api" {
  name                = "cloud-fp-${var.ENV}-api"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "api" {
  name                = "cloud-fp-${var.ENV}-api"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.api.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_ENABLE_CI"                    = "true"
    "DATABASE_URL"                        = "postgresql://${var.PSQL_USERNAME}:${var.PSQL_PASSWORD}@${azurerm_postgresql_server.this.fqdn}:5432/database?sslmode=require"
  }

  site_config {
    application_stack {
      docker_image = "berkeli/cloud-fp-api-${var.ENV}"
    }
  }
}
