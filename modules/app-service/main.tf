# Get secrets from Key Vault
data "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group
}

data "azurerm_key_vault_secret" "app_connection_string" {
  name         = "app-connection-string"
  key_vault_id = data.azurerm_key_vault.main.id
}

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "${var.app_name}-plan-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku

  tags = var.tags
}

# App Service
resource "azurerm_linux_web_app" "main" {
  name                = "${var.app_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id

  app_settings = merge(var.app_settings, {
    "ENVIRONMENT"           = var.environment
    "DATABASE_CONNECTION"   = data.azurerm_key_vault_secret.app_connection_string.value
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  })

  site_config {
    always_on = var.always_on
    
    application_stack {
      node_version = var.node_version
    }

    cors {
      allowed_origins     = var.cors_allowed_origins
      support_credentials = var.cors_support_credentials
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Grant App Service access to Key Vault
resource "azurerm_key_vault_access_policy" "app_service" {
  key_vault_id = data.azurerm_key_vault.main.id
  tenant_id    = azurerm_linux_web_app.main.identity[0].tenant_id
  object_id    = azurerm_linux_web_app.main.identity[0].principal_id

  secret_permissions = [
    "Get", "List"
  ]
}