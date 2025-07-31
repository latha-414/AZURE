variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}

variable "database_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "sql_admin_username" {
  description = "SQL Server admin username"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL Server admin password"
  type        = string
  sensitive   = true
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "function_app_name" {
  description = "Name of the Function App"
  type        = string
}

variable "function_service_plan_name" {
  description = "Name of the Function App Service Plan"
  type        = string
}

variable "function_storage_name" {
  description = "Name of the Function App Storage Account"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "azure-terraform"
  }
}
