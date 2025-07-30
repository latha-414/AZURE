# Same structure as dev and qa, but for production
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false  # Keep soft delete in production
      recover_soft_deleted_key_vaults = true
    }
  }
}

# Resource Group Module
module "resource_group" {
  source = "../../modules/resource-group"
  
  resource_group_name = var.resource_group_name
  location           = var.location
  tags               = var.tags
}

# Key Vault Module
module "key_vault" {
  source = "../../modules/key-vault"
  
  key_vault_name               = var.key_vault_name
  environment                 = var.environment
  resource_group_name         = module.resource_group.resource_group_name
  location                   = module.resource_group.location
  sql_admin_password         = var.sql_admin_password
  app_connection_string      = var.app_connection_string
  function_app_key           = var.function_app_key
  purge_protection_enabled   = true  # Enable purge protection in production
  soft_delete_retention_days = 90    # Longer retention in production
  tags                       = var.tags
  
  depends_on = [module.resource_group]
}

# SQL Database Module
module "sql_database" {
  source = "../../modules/sql-database"
  
  sql_server_name            = var.sql_server_name
  database_name             = var.database_name
  environment               = var.environment
  resource_group_name       = module.resource_group.resource_group_name
  location                 = module.resource_group.location
  administrator_login       = var.sql_administrator_login
  key_vault_name           = module.key_vault.key_vault_name
  key_vault_resource_group = module.resource_group.resource_group_name
  database_sku             = var.database_sku
  max_size_gb              = var.database_max_size_gb
  allowed_ip_ranges        = var.sql_allowed_ip_ranges
  azuread_admin_login      = var.azuread_admin_login
  azuread_admin_object_id  = var.azuread_admin_object_id
  tags                     = var.tags
  
  depends_on = [module.resource_group, module.key_vault]
}

# App Service Module
module "app_service" {
  source = "../../modules/app-service"
  
  app_name                     = var.app_name
  environment                  = var.environment
  resource_group_name          = module.resource_group.resource_group_name
  location                     = module.resource_group.location
  app_service_plan_sku         = var.app_service_plan_sku
  key_vault_name              = module.key_vault.key_vault_name
  key_vault_resource_group    = module.resource_group.resource_group_name
  app_settings                = var.app_settings
  always_on                   = var.app_always_on
  cors_allowed_origins        = var.cors_allowed_origins
  tags                        = var.tags
  
  depends_on = [module.resource_group, module.key_vault, module.sql_database]
}

# Azure Functions Module
module "azure_functions" {
  source = "../../modules/azure-functions"
  
  function_app_name           = var.function_app_name
  environment                = var.environment
  resource_group_name        = module.resource_group.resource_group_name
  location                  = module.resource_group.location
  function_app_sku          = var.function_app_sku
  key_vault_name            = module.key_vault.key_vault_name
  key_vault_resource_group  = module.resource_group.resource_group_name
  functions_worker_runtime  = var.functions_worker_runtime
  app_settings              = var.function_app_settings
  cors_allowed_origins      = var.function_cors_allowed_origins
  tags                      = var.tags
  
  depends_on = [module.resource_group, module.key_vault]
}