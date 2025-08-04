output "sql_server_id" {
  description = "ID of the SQL Server"
  value       = azurerm_mssql_server.this.id
}

output "database_id" {
  description = "ID of the SQL Database"
  value       = azurerm_mssql_database.this.id
}

output "connection_string" {
  description = "Connection string for the database"
  value       = "Server=${azurerm_mssql_server.this.fully_qualified_domain_name};Database=${azurerm_mssql_database.this.name};User ID=${var.admin_username};Password=${var.admin_password};Encrypt=true;Connection Timeout=30;"
  sensitive   = true
}
