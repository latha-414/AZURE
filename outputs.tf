output "app_service_url" {
  value       = "https://${azurerm_app_service.app.default_site_hostname}"
  description = "Default URL of the App Service"
}

output "apim_gateway_url" {
  value       = azurerm_api_management.apim.gateway_url
  description = "Gateway URL of the API Management Service"
}
