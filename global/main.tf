locals {
  environment = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  rg_name = "${var.rg_name}-${terraform.workspace}"
}

resource "azurerm_resource_group" "rg" {
  name = local.rg_name
  location = var.rg_location
}

output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "rg_location" {
  value = azurerm_resource_group.rg.location
}