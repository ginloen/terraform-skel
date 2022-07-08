variable "account_tier" {
  type        = string
  description = "storage account tier"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "type of replication"
  default     = "LRS"
}

#resource group name to be specified at runtime
variable "resource_group_name" {
  type = string
  description = "name of resource group"
}

variable "location" {
  type    = string
  description = "location of resource"
  default = "southeastasia"
}

variable "naming_prefix_sa" {
  type    = string
  default = "azuretfstate"
}

variable "naming_prefix_sc" {
  type    = string
  default = "azure-tfstate"
}

#environment to be specified at runtime
variable "environment" {
  type    = string
  description = "resource environment; dev/staging/prod"
}