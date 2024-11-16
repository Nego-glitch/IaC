variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

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

variable "sql_database_name" {
  description = "The name of the SQL Database"
  type        = string
}

variable "edition" {
  description = "The edition of the SQL Database"
  type        = string
  default     = "Basic"
}

variable "requested_service_objective_name" {
  description = "The service objective for the SQL Database"
  type        = string
  default     = "S0"
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
