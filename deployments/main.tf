data "terraform_remote_state" "global" {
  backend = "azurerm"
  config = {
    resource_group_name   = "rg-backend-valerija-operaterra"
    storage_account_name  = "sabeotwqlq7ed"
    container_name        = "tfstate"
    key                   = "global.terraform.tfstate"                
  }
}

locals {
  environment = terraform.workspace
  unique_name = "${random_id.random_id.dec}-${local.environment}"
  resource_group = "rg-valot-${local.environment}"
}

resource "random_id" "random_id" {
    byte_length = 3
}

# Networking Module
module "networking" {
  source              = "../modules/networking"
  vnet_name           = "vnet-${local.unique_name}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = local.resource_group
  subnet_name         = "subnet-${local.unique_name}"
  subnet_prefixes     = ["10.0.1.0/24"]
  nsg_name            = "nsg-${local.unique_name}"
}

# SQL Database Module
module "database" {
  source                        = "../modules/database"
  sql_server_name               = "sqlserver-${local.unique_name}"
  resource_group_name           = local.resource_group
  location                      = var.location
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  sql_database_name             = "sqldb-${local.unique_name}"
  edition                       = var.sql_database_edition
  requested_service_objective_name = var.sql_database_service_objective
  tags                          = {
    environment = local.environment
  }
}

# Storage Module
module "storage" {
  source                  = "../modules/storage"
  storage_account_name    = "storage${local.unique_name}"
  resource_group_name     = local.resource_group
  location                = var.location
  container_name          = "product-images"
  tags                    = {
    environment = local.environment
  }
}

# App Service Module
module "app_service" {
  source                  = "../modules/app_service"
  app_service_plan_name   = "asp-${local.unique_name}"
  location                = var.location
  resource_group_name     = local.resource_group
  app_service_plan_tier   = var.app_service_plan_tier
  app_service_plan_size   = var.app_service_plan_size
  app_service_plan_capacity = var.app_service_plan_capacity
  app_service_name        = "app-${local.unique_name}"
  app_settings            = var.app_settings
}

# Load Balancer Resources
resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-${local.unique_name}"
  location            = var.location
  resource_group_name = local.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = "lb-${local.unique_name}"
  location            = var.location
  resource_group_name = local.resource_group
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

# NN Deployment Module
module "nn" {
  source                  = "../modules/nn"
  slot_name               = "slot-${local.unique_name}"
  location                = var.location
  resource_group_name     = local.resource_group
  app_service_plan_id     = module.app_service.app_service_plan_id
  app_service_name        = module.app_service.app_service_id
  app_settings            = var.app_settings
}