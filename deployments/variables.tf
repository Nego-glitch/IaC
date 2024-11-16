variable "location" {
  description = "The location/region where the resources will be created"
  type        = string
}

variable "administrator_login" {
  description = "The administrator login name for the SQL Server"
  type        = string
}

variable "administrator_login_password" {
  description = "The administrator login password for the SQL Server"
  type        = string
  sensitive   = true
}

variable "sql_database_edition" {
  description = "The edition of the SQL Database"
  type        = string
  default     = "Standard"
}

variable "sql_database_service_objective" {
  description = "The service objective for the SQL Database"
  type        = string
  default     = "S1"
}

variable "app_service_plan_tier" {
  description = "The pricing tier of the App Service Plan"
  type        = string
}

variable "app_service_plan_size" {
  description = "The instance size of the App Service Plan"
  type        = string
}

variable "app_service_plan_capacity" {
  description = "The number of instances of the App Service Plan"
  type        = number
}

variable "app_settings" {
  description = "A map of app settings for the App Service"
  type        = map(string)
  default     = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}