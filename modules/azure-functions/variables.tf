variable "function_app_name" {
  description = "Name of the Function App"
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

variable "function_app_sku" {
  description = "SKU for the Function App Plan"
  type        = string
  default     = "Y1"  # Consumption plan
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "key_vault_resource_group" {
  description = "Resource group of the Key Vault"
  type        = string
}

variable "functions_worker_runtime" {
  description = "Functions worker runtime"
  type        = string
  default     = "node"
}

variable "app_settings" {
  description = "Additional app settings"
  type        = map(string)
  default     = {}
}

variable "always_on" {
  description = "Always on setting (not applicable for Consumption plan)"
  type        = bool
  default     = false
}

variable "node_version" {
  description = "Node.js version"
  type        = string
  default     = "18"
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