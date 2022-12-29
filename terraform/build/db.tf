resource "azurerm_postgresql_server" "this" {
  name                = "cloud-fp-${var.ENV}"
  location            = var.LOCATION
  resource_group_name = data.azurerm_resource_group.this.name

  administrator_login          = var.PSQL_USERNAME
  administrator_login_password = var.PSQL_PASSWORD

  sku_name   = "B_Gen5_1"
  version    = "11"
  storage_mb = 5120

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  lifecycle {
    ignore_changes = [
      administrator_login_password,
      administrator_login,
    ]
    prevent_destroy = false
  }
}

resource "azurerm_postgresql_database" "this" {
  name                = "database"
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.this.name
  charset             = "utf8"
  collation           = "English_United States.1252"
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_postgresql_firewall_rule" "this" {
  name                = "api"
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.this.name
  start_ip_address    = data.dns_a_record_set.api_ip.addrs[0]
  end_ip_address      = data.dns_a_record_set.api_ip.addrs[0]
}
