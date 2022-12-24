resource "azurerm_resource_group" "this" {
  name     = "Cloud-Final-Project-${var.ENV}"
  location = "West Europe"
}
