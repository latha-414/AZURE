output "app_service_id" {
  description = "ID of the App Service"
  value       = azurerm_linux_web_app.this.id
}

output "app_service_url" {
  description = "URL of the App Service"
  value       = "https://${azurerm_linux_web_app.this.default_hostname}"
}

output "service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.this.id
}
