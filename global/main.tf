terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.0.1"
    }
  }

  backend "azurerm" {
    resource_group_name   = "operaterra-rg"
    storage_account_name  = "operaterrastate"
    container_name        = "tfstate"
    key                   = "global.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Global Resource Group for State Storage
resource "azurerm_resource_group" "global_rg" {
  name     = "operaterra-rg"
  location = "West Europe"
}

# Storage Account for Remote State
resource "azurerm_storage_account" "global_storage" {
  name                     = "operaterrastate"
  resource_group_name      = azurerm_resource_group.global_rg.name
  location                 = azurerm_resource_group.global_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Container for Remote State
resource "azurerm_storage_container" "global_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.global_storage.name
  container_access_type = "private"
}
