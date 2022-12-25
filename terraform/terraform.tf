provider "azurerm" {
  features {}
}

terraform {

  backend "azurerm" {
    resource_group_name  = "Cloud-Final-Project"
    storage_account_name = "berkelifpstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.37.0"
    }
  }
}
