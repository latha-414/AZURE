terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  cloud {
    organization = "temperhcp"
    workspaces {
      name = "project-qa"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "../../modules/resource-group"
  
  resource_group_name = var.resource_group_name
  location           = var.location
  tags              = var.tags
}

module "key_vault" {
  source = "../../modules/key-vaults"
  
  key_vault_name      = var.key_vault_name
  location           = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  tags              = var.tags
}

module "sql_database" {
  source = "../../modules/sql-database"
  
  sql_server_name     = var.sql_server_name
  database_name      = var.database_name
  resource_group_name = module.resource_group.resource_group_name
  location           = module.resource_group.location
  admin_username     = var.sql_admin_username
  admin_password     = var.sql_admin_password
  tags              = var.tags
}

module "app_service" {
  source = "../../modules/app-service"
  
  app_name           = var.app_service_name
  service_plan_name  = var.app_service_plan_name
  resource_group_name = module.resource_group.resource_group_name
  location           = module.resource_group.location
  tags              = var.tags
}

module "azure_functions" {
  source = "../../modules/azure-functions"
  
  function_app_name      = var.function_app_name
  service_plan_name      = var.function_service_plan_name
  storage_account_name   = var.function_storage_name
  resource_group_name    = module.resource_group.resource_group_name
  location              = module.resource_group.location
  tags                 = var.tags
}
