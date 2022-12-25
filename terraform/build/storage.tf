resource "azurerm_storage_account" "this" {
  name                      = "cloudfp${var.ENV}storage"
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  tags = {
    environment = var.ENV
  }
}
