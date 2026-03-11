resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "azureadmin"
  administrator_login_password = "p@s$w0rd@123"

  azuread_administrator {
    login_username      = var.sql_azuread_login
    object_id           = var.sid
    tenant_id           = var.tenant_id
  }
  
  public_network_access_enabled       = false
  minimum_tls_version                 = "1.2"
  outbound_network_restriction_enabled = false

  identity {
    type = "SystemAssigned"
  }

  tags = var.resource_tags
}

resource "azurerm_mssql_database" "sqldb" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.sqlserver.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  sku_name = "Basic"
  max_size_gb = 1
  zone_redundant = false
  auto_pause_delay_in_minutes = var.compute_tier == "serverless" ? 60 : null
  tags = var.resource_tags
  short_term_retention_policy {
    retention_days =  var.pitr_retention_days
    backup_interval_in_hours = var.pitr_diff_backup_interval_in_hours
  }

  long_term_retention_policy {
    weekly_retention  = var.ltr_weekly_retention
    monthly_retention = var.ltr_monthly_retention
    yearly_retention  = var.ltr_yearly_retention
    week_of_year      = var.ltr_week_of_year
  }

}