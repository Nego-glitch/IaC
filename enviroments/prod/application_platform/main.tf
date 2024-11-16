provider "azurerm" {
  features {}
}

locals {
  environment = "prod"
  unique_name = "${random_pet.name.id}-${local.environment}"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.unique_name}"
  location = var.location
}

# App Service Module
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

# provider "azurerm" {
#   features {}
# }

# locals {
#   environment = "prod"
#   unique_name = "${random_pet.name.id}-${local.environment}"
# }

# # App Service Plan
# resource "azurerm_app_service_plan" "asp" {
#   name                = "asp-${local.unique_name}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku {
#     tier     = "Standard"
#     size     = "S1"
#     capacity = 1
#   }
# }

# # App Service
# resource "azurerm_app_service" "app" {
#   name                = "app-${local.unique_name}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   app_service_plan_id = azurerm_app_service_plan.asp.id
#   site_config {
#     always_on = true
#   }
#   app_settings = {
#     "WEBSITE_RUN_FROM_PACKAGE" = "1"
#   }
# }
