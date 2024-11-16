resource "azurerm_app_service_slot" "slot" {
  name                = var.slot_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id
  app_service_name    = var.app_service_name
  site_config {
    always_on = true
  }
  app_settings = var.app_settings
}
