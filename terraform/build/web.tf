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
    "API_URL"                             = "http://${data.dns_a_record_set.api_ip.addrs[0]}"
  }
  site_config {
    health_check_path = "/api/healthz"
  }

}

resource "azurerm_monitor_diagnostic_setting" "web" {
  name               = "cloud-fp-${var.ENV}-web-logs"
  target_resource_id = azurerm_linux_web_app.api.id
  storage_account_id = azurerm_storage_account.this.id

  log {
    category = "AppServiceConsoleLogs"
    enabled  = true

    retention_policy {
      days    = 7
      enabled = true
    }
  }

  log {
    category = "AppServiceHTTPLogs"
    enabled  = true

    retention_policy {
      days    = 7
      enabled = true
    }
  }

  log {
    category = "AppServiceIPSecAudit"
    enabled  = false

    retention_policy {
      days    = 7
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

data "dns_a_record_set" "web_ip" {
  host = azurerm_linux_web_app.web.default_hostname
}
