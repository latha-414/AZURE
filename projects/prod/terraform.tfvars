# Environment Configuration
environment         = "prod"
location           = "East US"
resource_group_name = "rg-myapp-prod"

# Key Vault Configuration
key_vault_name      = "kv-myapp"
sql_admin_password  = "Pr0d-P@ssw0rd123!"  # Strong password for production
app_connection_string = "DefaultEndpointsProtocol=https;AccountName=myappprod;AccountKey=your-prod-key-here"
function_app_key   = "your-prod-function-app-key-here"

# SQL Database Configuration
sql_server_name           = "myapp-sql"
database_name            = "myappdb"
sql_administrator_login  = "sqladmin"
database_sku            = "P2"           # Premium tier for production
database_max_size_gb    = 100           # Large for production
sql_allowed_ip_ranges   = [
  {
    start_ip = "52.168.1.1"    # Production IP ranges
    end_ip   = "52.168.1.255"
  }
]

# App Service Configuration
app_name                = "myapp"
app_service_plan_sku    = "P1v2"         # Premium tier for production
app_always_on          = true           # Always enable for production
app_settings = {
  "NODE_ENV"           = "production"
  "API_VERSION"        = "v1"
  "LOG_LEVEL"         = "error"
}

# Azure Functions Configuration
function_app_name         = "myapp-functions"
function_app_sku         = "EP1"         # Elastic Premium for production
functions_worker_runtime = "node"
function_app_settings = {
  "NODE_ENV"             = "production"
  "FUNCTIONS_WORKER_RUNTIME" = "node"
  "LOG_LEVEL"           = "error"
}

# Tags
tags = {
  Environment = "Production"
  Project     = "MyApp"
  Owner       = "ProductionTeam"
  CostCenter  = "IT-PROD"
  Backup      = "Required"
  Monitoring  = "Critical"
}