terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.0.1"
    }

    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }

  backend "azurerm" {
    resource_group_name   = "rg-backend-valerija-operaterra"
    storage_account_name  = "sabeot93r17j7"
    container_name        = "tfstate"
    key                   = "deployment.terraform.tfstate"
  }
}

provider "azurerm" {
  features {

  }
}