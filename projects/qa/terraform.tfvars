# Environment Configuration
environment         = "qa"
location           = "East US"
resource_group_name = "rg-myapp-qa"

# Key Vault Configuration
key_vault_name      = "kv-myapp"
sql_admin_password  = "P@ssw0rd123!QA"  # Different password for QA
app_connection_string = "DefaultEndpointsProtocol=https;AccountName=myappqa;AccountKey=your-qa-key-here"
function_app_key   = "your-qa-function-app-key-here"

# SQL Database Configuration
sql_server_name           = "myapp-sql"
database_name            = "myappdb"
sql_administrator_login  = "sqladmin"
database_sku            = "S1"          # Higher tier for QA
database_max_size_gb    = 10            # Larger for QA
sql_allowed_ip_ranges   = [
  {
    start_ip = "0.0.0.0"
    end_ip   = "0.0.0.0"
  }
]

# App Service Configuration
app_name                = "myapp"
app_service_plan_sku    = "S1"          # Higher tier for QA
app_always_on          = true           # Enable for QA
app_settings = {
  "NODE_ENV"           = "qa"
  "API_VERSION"        = "v1"
  "LOG_LEVEL"         = "info"
}

# Azure Functions Configuration
function_app_name         = "myapp-functions"
function_app_sku         = "S1"         # Premium plan for QA
functions_worker_runtime = "node"
function_app_settings = {
  "NODE_ENV"             = "qa"
  "FUNCTIONS_WORKER_RUNTIME" = "node"
  "LOG_LEVEL"           = "info"
}

# Tags
tags = {
  Environment = "QA"
  Project     = "MyApp"
  Owner       = "QATeam"
  CostCenter  = "IT-QA"
}