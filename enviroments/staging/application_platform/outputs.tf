output "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_app_service_plan.asp.id
}

output "app_service_id" {
  description = "The ID of the App Service"
  value       = azurerm_app_service.app.id
}
