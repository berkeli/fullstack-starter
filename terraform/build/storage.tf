resource "azurerm_storage_account" "this" {
  name                      = "cloudfp${var.ENV}storage"
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  allow_blob_public_access  = true
  tags = {
    environment = var.ENV
  }
}
