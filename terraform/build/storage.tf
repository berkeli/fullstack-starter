resource "azurerm_storage_account" "this" {
  name                      = "cloudfp${var.ENV}logs"
  resource_group_name       = data.azurerm_resource_group.this.name
  location                  = data.azurerm_resource_group.this.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  tags = {
    environment = var.ENV
  }
}
