output "resource_group_name" {
  description = "The name of the resource group"
  value       = local.resource_group
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = module.networking.vnet_id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = module.networking.subnet_id
}

output "nsg_id" {
  description = "The ID of the network security group"
  value       = module.networking.nsg_id
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
  value       = module.app_service.app_service_plan_id
}

output "app_service_id" {
  description = "The ID of the App Service"
  value       = module.app_service.app_service_id
}

output "app_service_slot_id" {
  description = "The ID of the App Service Slot"
  value       = module.nn.app_service_slot_id
}