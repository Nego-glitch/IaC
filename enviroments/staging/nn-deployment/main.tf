provider "azurerm" {
  features {}
}

locals {
  environment = "staging"
  unique_name = "${random_pet.name.id}-${local.environment}"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.unique_name}"
  location = var.location
}

# App Service Plan and App Service (assuming these are already created)
module "app_service" {
  source                  = "../../modules/app_service"
  app_service_plan_name   = "asp-${local.unique_name}"
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg.name
  app_service_plan_tier   = "Standard"
  app_service_plan_size   = "S1"
  app_service_plan_capacity = 1
  app_service_name        = "app-${local.unique_name}"
  app_settings            = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

# NN Deployment Module
module "nn" {
  source                  = "../../modules/nn"
  slot_name               = "slot-${local.unique_name}"
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg.name
  app_service_plan_id     = module.app_service.app_service_plan_id
  app_service_name        = module.app_service.app_service_id
  app_settings            = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

# provider "azurerm" {
#   features {}
# }

# locals {
#   environment = "staging"
#   unique_name = "${random_pet.name.id}-${local.environment}"
# }

# # Deployment Slot
# resource "azurerm_app_service_slot" "slot" {
#   name                = "slot-${local.unique_name}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   app_service_plan_id = var.app_service_plan_id
#   app_service_name    = var.app_service_name
#   site_config {
#     always_on = true
#   }
#   app_settings = {
#     "WEBSITE_RUN_FROM_PACKAGE" = "1"
#   }
# }
