terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.23.0"
    }
  }

 #backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id = "18a0e420-4ca6-47f3-ba52-2534b3c7d2c1" # optional if set in service connection
}
