output "app_service_slot_id" {
  description = "The ID of the App Service Slot"
  value       = azurerm_app_service_slot.slot.id
}
