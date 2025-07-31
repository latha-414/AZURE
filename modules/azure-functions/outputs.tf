output "function_app_id" {
  description = "ID of the Function App"
  value       = azurerm_linux_function_app.this.id
}

output "function_app_url" {
  description = "URL of the Function App"
  value       = "https://${azurerm_linux_function_app.this.default_hostname}"
}

output "storage_account_id" {
  description = "ID of the Storage Account"
  value       = azurerm_storage_account.this.id
}
