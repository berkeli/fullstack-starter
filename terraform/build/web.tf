resource "azurerm_service_plan" "web" {
  name                = "cloud-fp-${var.ENV}-web"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "B1"

}

resource "azurerm_linux_web_app" "web" {
  name                = "cloud-fp-${var.ENV}-web"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.api.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_ENABLE_CI"                    = "true"
    "WEBSITES_PORT"                       = "3000"
    "API_URL"                             = "http://${data.dns_a_record_set.api_ip.addrs[0]}"
  }
  site_config {
    health_check_path = "/api/healthz"
    application_stack {
      name    = "node"
      version = "16-lts"
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "web" {
  name               = "cloud-fp-${var.ENV}-web-logs"
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

data "dns_a_record_set" "web_ip" {
  host = azurerm_linux_web_app.web.default_hostname
}
