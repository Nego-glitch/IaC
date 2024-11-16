output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_connection_string" {
  description = "The primary connection string for the Storage Account"
  value       = azurerm_storage_account.storage_account.primary_connection_string
}

output "storage_container_name" {
  description = "The name of the Blob Container"
  value       = azurerm_storage_container.storage_container.name
}
