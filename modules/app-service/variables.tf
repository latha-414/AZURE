variable "app_name" {
  description = "Name of the application"
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

variable "app_service_plan_sku" {
  description = "SKU for the App Service Plan"
  type        = string
  default     = "B1"
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "key_vault_resource_group" {
  description = "Resource group of the Key Vault"
  type        = string
}

variable "app_settings" {
  description = "Additional app settings"
  type        = map(string)
  default     = {}
}

variable "always_on" {
  description = "Always on setting for App Service"
  type        = bool
  default     = false
}

variable "node_version" {
  description = "Node.js version"
  type        = string
  default     = "18-lts"
}

variable "cors_allowed_origins" {
  description = "CORS allowed origins"
  type        = list(string)
  default     = ["*"]
}

variable "cors_support_credentials" {
  description = "CORS support credentials"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}