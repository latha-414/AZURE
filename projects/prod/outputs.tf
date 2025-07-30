# Same as dev and qa outputs
# Resource Group Outputs
output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = module.resource_group.location
}

# Key Vault Outputs
output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = module.key_vault.key_vault_name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = module.key_vault.key_vault_uri
}

# SQL Database Outputs
output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = module.sql_database.sql_server_name
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = module.sql_database.sql_server_fqdn
}

output "database_name" {
  description = "Name of the SQL Database"
  value       = module.sql_database.database_name
}

# App Service Outputs
output "app_service_name" {
  description = "Name of the App Service"
  value       = module.app_service.app_service_name
}

output "app_service_url" {
  description = "URL of the App Service"
  value       = module.app_service.app_service_url
}

# Azure Functions Outputs
output "function_app_name" {
  description = "Name of the Function App"
  value       = module.azure_functions.function_app_name
}

output "function_app_url" {
  description = "URL of the Function App"
  value       = module.azure_functions.function_app_url
}

# Production-specific outputs
output "environment_summary" {
  description = "Summary of the production environment"
  value = {
    environment           = var.environment
    resource_group       = module.resource_group.resource_group_name
    app_service_sku      = var.app_service_plan_sku
    function_app_sku     = var.function_app_sku
    database_sku         = var.database_sku
    key_vault_name       = module.key_vault.key_vault_name
  }
}