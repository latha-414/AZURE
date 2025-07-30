# Same structure as dev and qa with production defaults
# Common Variables
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "MyApp"
  }
}

# Key Vault Variables
variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL Server admin password"
  type        = string
  sensitive   = true
}

variable "app_connection_string" {
  description = "Application connection string"
  type        = string
  sensitive   = true
  default     = ""
}

variable "function_app_key" {
  description = "Function app key"
  type        = string
  sensitive   = true
  default     = ""
}

# SQL Database Variables
variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}

variable "database_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "sql_administrator_login" {
  description = "SQL Server administrator login"
  type        = string
  default     = "sqladmin"
}

variable "database_sku" {
  description = "SKU for the database"
  type        = string
  default     = "P2"  # Premium tier for production
}

variable "database_max_size_gb" {
  description = "Maximum size of the database in GB"
  type        = number
  default     = 100   # Large for production
}

variable "sql_allowed_ip_ranges" {
  description = "List of allowed IP ranges for SQL Server"
  type = list(object({
    start_ip = string
    end_ip   = string
  }))
  default = []
}

variable "azuread_admin_login" {
  description = "Azure AD admin login for SQL Server"
  type        = string
  default     = ""
}

variable "azuread_admin_object_id" {
  description = "Azure AD admin object ID for SQL Server"
  type        = string
  default     = ""
}

# App Service Variables
variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "app_service_plan_sku" {
  description = "SKU for the App Service Plan"
  type        = string
  default     = "P1v2"  # Premium tier for production
}

variable "app_settings" {
  description = "Additional app settings for App Service"
  type        = map(string)
  default     = {}
}

variable "app_always_on" {
  description = "Always on setting for App Service"
  type        = bool
  default     = true  # Always enable for production
}

variable "cors_allowed_origins" {
  description = "CORS allowed origins for App Service"
  type        = list(string)
  default     = []  # Restrict CORS in production
}

# Azure Functions Variables
variable "function_app_name" {
  description = "Name of the Function App"
  type        = string
}

variable "function_app_sku" {
  description = "SKU for the Function App Plan"
  type        = string
  default     = "EP1"  # Elastic Premium for production
}

variable "functions_worker_runtime" {
  description = "Functions worker runtime"
  type        = string
  default     = "node"
}

variable "function_app_settings" {
  description = "Additional app settings for Function App"
  type        = map(string)
  default     = {}
}

variable "function_cors_allowed_origins" {
  description = "CORS allowed origins for Function App"
  type        = list(string)
  default     = []  # Restrict CORS in production
}