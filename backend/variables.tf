variable "location" {
  description = "The location/region where the resources will be created"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default = "rg-valerija-operaterra"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type = string
  default = "sa-operaterra"
}

variable "storage_container_name" {
  description = "The name of the storage container"
  type = string
}

variable "key_vault_name" {
  description = "The name of the key vault"
  type = string
}

variable "sa_backend_key_name" {
  description = "The name of the secret holding access key to storage account"
  type = string
}