provider "azurerm" {
  features {}
}

terraform {

  backend "azurerm" {
    resource_group_name  = "Cloud-Final-Project-staging"
    storage_account_name = "berkelifpstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.37.0"
    }
  }
}
