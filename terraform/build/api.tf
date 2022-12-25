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
    "WEBSITES_PORT"                       = "4000"
    "DATABASE_URL"                        = "postgresql://${var.PSQL_USERNAME}%40${azurerm_postgresql_server.this.name}:${var.PSQL_PASSWORD}@${azurerm_postgresql_server.this.fqdn}:5432/postgres?sslmode=require"
  }

  site_config {
    health_check_path = "/v1"
    app_command_line  = "pm2 start dist/src/main.js --no-daemon"
    application_stack {
      node_version = "16-lts"
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "api" {
  name               = "cloud-fp-${var.ENV}-api-logs"
  target_resource_id = azurerm_linux_web_app.api.id
  storage_account_id = azurerm_storage_account.this.id

  log {
    category = "AppServiceHTTPLogs"
    enabled  = true

    retention_policy {
      days    = 7
      enabled = true
    }
  }

  log {
    category = "AppServiceConsoleLogs"
    enabled  = true
    retention_policy {
      days    = 7
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      days    = 3
      enabled = false
    }
  }
  # This is a workaround for azure caching issue. If you don't ignore changes, it will throw 409 error.
  # To update the diagnostic settings, you need to destroy the resource and recreate it.
  lifecycle {
    ignore_changes = [
      log,
      metric,
    ]
  }
}

data "dns_a_record_set" "api_ip" {
  host = azurerm_linux_web_app.api.default_hostname
}
