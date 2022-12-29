resource "azurerm_service_plan" "api" {
  name                = "cloud-fp-${var.ENV}-api"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = var.LOCATION
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "api" {
  name                = "cloud-fp-${var.ENV}-api"
  location            = var.LOCATION
  resource_group_name = data.azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.api.id
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITES_PORT"                       = "4000"
    "DATABASE_URL"                        = "postgresql://${azurerm_postgresql_server.this.administrator_login}@${azurerm_postgresql_server.this.name}:${azurerm_postgresql_server.this.administrator_login_password}@${azurerm_postgresql_server.this.fqdn}:5432/database?sslmode=require"
  }

  depends_on = [
    azurerm_postgresql_database.this,
  ]

  site_config {
    health_check_path = "/v1"
    application_stack {
      node_version = "16-lts"
    }

    dynamic "ip_restriction" {
      for_each = split(",", azurerm_linux_web_app.web.outbound_ip_addresses)
      content {
        ip_address = "${ip_restriction.value}/32"
        name       = "Allow ${ip_restriction.value}"
        priority   = 200
        action     = "Allow"
      }
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

resource "azurerm_app_service_connection" "api_to_db" {
  name               = "cloud_fp_${var.ENV}_api_to_db"
  app_service_id     = azurerm_linux_web_app.api.id
  target_resource_id = azurerm_postgresql_database.this.id
  client_type        = "nodejs"
  authentication {
    type   = "secret"
    name   = azurerm_postgresql_server.this.administrator_login
    secret = azurerm_postgresql_server.this.administrator_login_password
  }
}

data "dns_a_record_set" "api_ip" {
  host = azurerm_linux_web_app.api.default_hostname
}
