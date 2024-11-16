output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.subnet.id
}

output "nsg_id" {
  description = "The ID of the network security group"
  value       = azurerm_network_security_group.nsg.id
}

output "public_ip_id" {
  description = "The ID of the public IP"
  value       = azurerm_public_ip.public_ip.id
}

output "lb_id" {
  description = "The ID of the load balancer"
  value       = azurerm_lb.lb.id
}

output "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_app_service_plan.asp.id
}

output "app_service_id" {
  description = "The ID of the App Service"
  value       = azurerm_app_service.app.id
}

output "app_service_slot_id" {
  description = "The ID of the App Service Slot"
  value       = azurerm_app_service_slot.slot.id
}
