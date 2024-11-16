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

# Networking Module
module "networking" {
  source              = "../../modules/networking"
  vnet_name           = "vnet-${local.unique_name}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_name         = "subnet-${local.unique_name}"
  subnet_prefixes     = ["10.0.1.0/24"]
  nsg_name            = "nsg-${local.unique_name}"
}

# SQL Database Module
module "database" {
  source                        = "../../modules/database"
  sql_server_name               = "sqlserver-${local.unique_name}"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = var.location
  administrator_login           = "adminuser"
  administrator_login_password  = "P@ssw0rd1234!"
  sql_database_name             = "sqldb-${local.unique_name}"
  edition                       = "Standard"
  requested_service_objective_name = "S1"
  tags                          = {
    environment = local.environment
  }
}

# Storage Module
module "storage" {
  source                  = "../../modules/storage"
  storage_account_name    = "storage${local.unique_name}"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = var.location
  container_name          = "product-images"
  tags                    = {
    environment = local.environment
  }
}

# provider "azurerm" {
#   features {}
# }

# locals {
#   environment = "prod"
#   unique_name = "${random_pet.name.id}-${local.environment}"
# }

# # Resource Group
# resource "azurerm_resource_group" "rg" {
#   name     = "rg-${local.unique_name}"
#   location = var.location
# }

# # Virtual Network
# resource "azurerm_virtual_network" "vnet" {
#   name                = "vnet-${local.unique_name}"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# # Subnet
# resource "azurerm_subnet" "subnet" {
#   name                 = "subnet-${local.unique_name}"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

# # Network Security Group
# resource "azurerm_network_security_group" "nsg" {
#   name                = "nsg-${local.unique_name}"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# # Associate NSG with Subnet
# resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
#   subnet_id                 = azurerm_subnet.subnet.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }

# # Public IP for Load Balancer
# resource "azurerm_public_ip" "public_ip" {
#   name                = "public-ip-${local.unique_name}"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# # Load Balancer
# resource "azurerm_lb" "lb" {
#   name                = "lb-${local.unique_name}"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   sku                 = "Standard"
#   frontend_ip_configuration {
#     name                 = "frontend"
#     public_ip_address_id = azurerm_public_ip.public_ip.id
#   }
# }

# # # Load Balancer Backend Pool
# # resource "azurerm_lb_backend_address_pool" "backend_pool" {
# #   name                = "backend-pool"
# #   loadbalancer_id     = azurerm_lb.lb.id
# #   resource_group_name = azurerm_resource_group.rg.name
# # }

# # # Load Balancer Probe
# # resource "azurerm_lb_probe" "lb_probe" {
# #   name                = "http-probe"
# #   resource_group_name = azurerm_resource_group.rg.name
# #   loadbalancer_id     = azurerm_lb.lb.id
# #   protocol            = "Http"
# #   port                = 80
# #   request_path        = "/"
# # }

# # # Load Balancer Rule
# # resource "azurerm_lb_rule" "lb_rule" {
# #   name                           = "http-rule"
# #   resource_group_name            = azurerm_resource_group.rg.name
# #   loadbalancer_id                = azurerm_lb.lb.id
# #   protocol                       = "Tcp"
# #   frontend_port                  = 80
# #   backend_port                   = 80
# #   frontend_ip_configuration_name = "frontend"
# #   backend_address_pool_id        = azurerm_lb_backend_address_pool.backend_pool.id
# #   probe_id                       = azurerm_lb_probe.lb_probe.id
# # }
