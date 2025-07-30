output "function_app_name" {
  description = "Name of the Function App"
  value       = azurerm_linux_function_app.main.name
}

output "function_app_url" {
  description = "URL of the Function App"
  value       = "https://${azurerm_linux_function_app.main.default_hostname}"
}

output "function_app_id" {
  description = "ID of the Function App"
  value       = azurerm_linux_function_app.main.id
}

output "function_app_principal_id" {
  description = "Principal ID of the Function App managed identity"
  value       = azurerm_linux_function_app.main.identity[0].principal_id
}

output "storage_account_name" {
  description = "Name of the storage account for functions"
  value       = azurerm_storage_account.functions.name
}

output "application_insights_instrumentation_key" {
  description = "Application Insights instrumentation key"
  value       = azurerm_application_insights.functions.instrumentation_key
  sensitive   = true
}