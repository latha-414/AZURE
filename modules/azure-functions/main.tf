# Get secrets from Key Vault
data "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group
}

data "azurerm_key_vault_secret" "function_app_key" {
  name         = "function-app-key"
  key_vault_id = data.azurerm_key_vault.main.id
}

# Storage Account for Functions
resource "azurerm_storage_account" "functions" {
  name                     = "${var.function_app_name}storage${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

# App Service Plan for Functions (Consumption Plan)
resource "azurerm_service_plan" "functions" {
  name                = "${var.function_app_name}-plan-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.function_app_sku

  tags = var.tags
}

# Function App
resource "azurerm_linux_function_app" "main" {
  name                = "${var.function_app_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name       = azurerm_storage_account.functions.name
  storage_account_access_key = azurerm_storage_account.functions.primary_access_key
  service_plan_id           = azurerm_service_plan.functions.id

  app_settings = merge(var.app_settings, {
    "ENVIRONMENT"                    = var.environment
    "FUNCTIONS_WORKER_RUNTIME"       = var.functions_worker_runtime
    "WEBSITE_RUN_FROM_PACKAGE"       = "1"
    "FUNCTION_APP_EDIT_MODE"         = "readonly"
    "AzureWebJobsDisableHomepage"    = "true"
    "FUNCTIONS_EXTENSION_VERSION"    = "~4"
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

# Grant Function App access to Key Vault
resource "azurerm_key_vault_access_policy" "function_app" {
  key_vault_id = data.azurerm_key_vault.main.id
  tenant_id    = azurerm_linux_function_app.main.identity[0].tenant_id
  object_id    = azurerm_linux_function_app.main.identity[0].principal_id

  secret_permissions = [
    "Get", "List"
  ]
}

# Application Insights for Functions
resource "azurerm_application_insights" "functions" {
  name                = "${var.function_app_name}-insights-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"

  tags = var.tags
}

# Update Function App with Application Insights
resource "azurerm_linux_function_app" "main_with_insights" {
  name                = azurerm_linux_function_app.main.name
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name       = azurerm_storage_account.functions.name
  storage_account_access_key = azurerm_storage_account.functions.primary_access_key
  service_plan_id           = azurerm_service_plan.functions.id

  app_settings = merge(azurerm_linux_function_app.main.app_settings, {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.functions.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.functions.connection_string
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

  depends_on = [azurerm_linux_function_app.main, azurerm_application_insights.functions]
}