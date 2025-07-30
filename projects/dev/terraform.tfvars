# Environment Configuration
environment         = "dev"
location           = "East US"
resource_group_name = "rg-myapp-dev"

# Key Vault Configuration
key_vault_name      = "kv-myapp"
sql_admin_password  = "P@ssw0rd123!"  # In production, use secure password generation
app_connection_string = "DefaultEndpointsProtocol=https;AccountName=myappdev;AccountKey=your-key-here"
function_app_key   = "your-function-app-key-here"

# SQL Database Configuration
sql_server_name           = "myapp-sql"
database_name            = "myappdb"
sql_administrator_login  = "sqladmin"
database_sku            = "S0"
database_max_size_gb    = 2
sql_allowed_ip_ranges   = [
  {
    start_ip = "0.0.0.0"
    end_ip   = "0.0.0.0"
  }
]

# App Service Configuration
app_name                = "myapp"
app_service_plan_sku    = "B1"
app_always_on          = false
app_settings = {
  "NODE_ENV"           = "development"
  "API_VERSION"        = "v1"
  "LOG_LEVEL"         = "debug"
}

# Azure Functions Configuration
function_app_name         = "myapp-functions"
function_app_sku         = "Y1"
functions_worker_runtime = "node"
function_app_settings = {
  "NODE_ENV"             = "development"
  "FUNCTIONS_WORKER_RUNTIME" = "node"
  "LOG_LEVEL"           = "debug"
}

# Tags
tags = {
  Environment = "Development"
  Project     = "MyApp"
  Owner       = "DevTeam"
  CostCenter  = "IT-DEV"
}