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
    key                   = "backend.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

resource "random_string" "random_string" {
  length = 7
  special = false
  upper = false
}

# Global Resource Group for State Storage
resource "azurerm_resource_group" "rg_backend" {
  name     = var.resource_group_name
  location = var.location
}

# Storage Account for Remote State
resource "azurerm_storage_account" "sa_backend" {
  name                     = "${lower(var.storage_account_name)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.rg_backend.name
  location                 = azurerm_resource_group.rg_backend.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# Storage Container for Remote State
resource "azurerm_storage_container" "sc_backend" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.sa_backend.name
  container_access_type = "private"
}

data "azurerm_client_config" "current" {}

# Key Vault to store connection secrets
resource "azurerm_key_vault" "kv_backend" {
  name                        = "${lower(var.key_vault_name)}${random_string.random_string.result}"
  location                    = azurerm_resource_group.rg_backend.location
  resource_group_name         = azurerm_resource_group.rg_backend.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "Create", "Delete", "List",
    ]

    secret_permissions = [
      "Get", "Set", "Delete", "List",
    ]

    storage_permissions = [
      "Get", "Set", "Delete", "List",
    ]
  }
}

resource "azurerm_key_vault_secret" "sa_backend_key" {
  name         = var.sa_backend_key_name
  value        = azurerm_storage_account.sa_backend.primary_access_key
  key_vault_id = azurerm_key_vault.kv_backend.id
}
