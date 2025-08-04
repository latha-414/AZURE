terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# App Service Plan
resource "azurerm_app_service_plan" "plan" {
  name                = "${var.prefix}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

# App Service
resource "azurerm_app_service" "app" {
  name                = "${var.prefix}-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
}

# API Management Service
resource "azurerm_api_management" "apim" {
  name                = "${var.prefix}-apim"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "My Company"
  publisher_email     = "admin@example.com"
  sku_name            = "Developer_1"
}

# API linked to App Service
resource "azurerm_api_management_api" "api" {
  name                = "${var.prefix}-api"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "My API"
  path                = "myapi"
  protocols           = ["https"]

  # Linking App Service URL
  service_url = "https://${azurerm_app_service.app.default_site_hostname}"
}
