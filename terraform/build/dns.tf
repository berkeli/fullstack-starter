resource "azurerm_dns_zone" "this" {
  name                = var.DOMAIN
  resource_group_name = azurerm_resource_group.this.name
}
