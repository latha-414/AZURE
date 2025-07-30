# Get SQL admin password from Key Vault
data "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group
}

data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  key_vault_id = data.azurerm_key_vault.main.id
}

# SQL Server
resource "azurerm_mssql_server" "main" {
  name                         = "${var.sql_server_name}-${var.environment}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = var.administrator_login
  administrator_login_password = data.azurerm_key_vault_secret.sql_admin_password.value
  
  minimum_tls_version = "1.2"

  azuread_administrator {
    login_username = var.azuread_admin_login
    object_id      = var.azuread_admin_object_id
  }

  tags = var.tags
}

# SQL Database
resource "azurerm_mssql_database" "main" {
  name           = "${var.database_name}-${var.environment}"
  server_id      = azurerm_mssql_server.main.id
  collation      = var.collation
  license_type   = var.license_type
  max_size_gb    = var.max_size_gb
  sku_name       = var.database_sku

  tags = var.tags
}

# SQL Server Firewall Rule - Allow Azure Services
resource "azurerm_mssql_firewall_rule" "azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# SQL Server Firewall Rules for allowed IPs
resource "azurerm_mssql_firewall_rule" "allowed_ips" {
  count            = length(var.allowed_ip_ranges)
  name             = "AllowedIP-${count.index}"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = var.allowed_ip_ranges[count.index].start_ip
  end_ip_address   = var.allowed_ip_ranges[count.index].end_ip
}