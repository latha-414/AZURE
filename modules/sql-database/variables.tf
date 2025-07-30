variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}

variable "database_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sql_server_version" {
  description = "Version of SQL Server"
  type        = string
  default     = "12.0"
}

variable "administrator_login" {
  description = "Administrator login for SQL Server"
  type        = string
  default     = "sqladmin"
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "key_vault_resource_group" {
  description = "Resource group of the Key Vault"
  type        = string
}

variable "azuread_admin_login" {
  description = "Azure AD admin login"
  type        = string
  default     = ""
}

variable "azuread_admin_object_id" {
  description = "Azure AD admin object ID"
  type        = string
  default     = ""
}

variable "collation" {
  description = "Database collation"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" {
  description = "License type for the database"
  type        = string
  default     = "LicenseIncluded"
}

variable "max_size_gb" {
  description = "Maximum size of the database in GB"
  type        = number
  default     = 2
}

variable "database_sku" {
  description = "SKU for the database"
  type        = string
  default     = "S0"
}

variable "allowed_ip_ranges" {
  description = "List of allowed IP ranges"
  type = list(object({
    start_ip = string
    end_ip   = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}