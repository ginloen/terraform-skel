terraform {
  backend "azurerm" {}
}

#create random 2-digit integer
resource "random_integer" "ri" {
  min = 00
  max = 99
}

module "appsvc-mod" {
  source = "../../../../modules/app-service"
  appsvc_name = "${var.environment}${random_integer.ri.result}"
  appsvc_rg_name = var.rg_name
  appsvc_region = var.location
  websvc_name = "${var.environment}-websvc-${random_integer.ri.result}"
}

output "webapp_hostname" {
  value = module.appsvc-mod.webapp_hostname
}