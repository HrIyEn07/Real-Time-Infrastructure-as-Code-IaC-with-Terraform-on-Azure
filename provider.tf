terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.23.0"
    }
  }

 backend "azurerm" {}
}

provider "azurerm" {
  features {}
  # subscription_id = "" # optional if set in service connection
}
