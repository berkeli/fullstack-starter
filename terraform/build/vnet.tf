resource "azurerm_virtual_network" "this" {
  name                = "Cloud-Final-Project-${var.ENV}-vnet"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  address_space       = ["10.0.0.0/16"]
}
