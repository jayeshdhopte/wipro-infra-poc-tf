resource_group_name = "rama-rg"
location            = "centralindia"

sql_server_name     = "rama-sqlserver-demo"
sql_db_name         = "rama-sqldb-demo"

sql_azuread_login   = "ramadevops"
sid                 = "f76b6b93-7ac2-4a0a-bb0e-414156cd2fb0"
tenant_id           = "2ea4351f-311e-45ce-8380-4bea38d1040c"

sku_tier            = "GeneralPurpose"

compute_tier        = "serverless"

pitr_diff_backup_interval_in_hours = 12
pitr_retention_days                = 7

ltr_weekly_retention  = "P1W"
ltr_monthly_retention = "P1M"
ltr_yearly_retention  = "P1Y"
ltr_week_of_year      = 1

resource_tags = {
  Environment = "Dev"
  Owner       = "CloudTeam"
}