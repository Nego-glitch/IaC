variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
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

variable "app_service_name" {
  description = "The name of the App Service"
  type        = string
}

variable "app_settings" {
  description = "A map of app settings for the App Service"
  type        = map(string)
  default     = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
