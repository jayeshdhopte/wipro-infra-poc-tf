output "sql_server_id" {
  value = azurerm_mssql_server.sqlserver.id
}

output "sql_database_id" {
  value = azurerm_mssql_database.sqldb.id
}