variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Location for SQL deployment"
  type        = string
}

variable "sql_server_name" {
  description = "SQL Server Name"
  type        = string
}

variable "sql_db_name" {
  description = "SQL Database Name"
  type        = string
}

variable "sql_azuread_login" {
  description = "Azure AD Admin Login"
  type        = string
}

variable "sid" {
  description = "Azure AD Admin Object ID"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "resource_tags" {
  description = "Resource Tags"
  type        = map(string)
}

variable "sku_tier" {
  description = "SQL SKU Tier"
  type        = string
}

variable "compute_tier" {
  description = "Compute Tier"
  type        = string
  default     = "serverless"
}

variable "pitr_diff_backup_interval_in_hours" {
  description = "Differential backup interval"
  type        = number
}

variable "pitr_retention_days" {
  description = "Short-term retention days"
  type        = number
}

variable "ltr_monthly_retention" {
  type = string
}

variable "ltr_weekly_retention" {
  type = string
}

variable "ltr_week_of_year" {
  type = number
}

variable "ltr_yearly_retention" {
  type = string
}
