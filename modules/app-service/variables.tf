variable "appsvc_name" {
  type        = string
  description = "name of app svc"
}

variable "appsvc_region" {
  type        = string
  description = "location of app svc"
}

variable "appsvc_rg_name" {
  type = string
  description = "name of resource group"
}

variable "appsvc_sku" {
  type = string
  description = "sku of app svc"
  default = "B1"
}

variable "websvc_name" {
  type = string
  description = "name of web svc"
}