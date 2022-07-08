variable "environment" {
  type        = string
  description = "env of app svc"
}

variable "rg_name" {
  type        = string
  description = "name of resource group"
}

variable "location" {
  type = string
  description = "location of app svc"
  default = "eastus"
}