resource "azurerm_service_plan" "appsvc" {
  name                = var.appsvc_name
  resource_group_name = var.appsvc_rg_name
  location            = var.appsvc_region
  os_type             = "Linux"
  sku_name            = var.appsvc_sku
}

resource "azurerm_linux_web_app" "webapp" {
  name                = var.websvc_name
  resource_group_name = var.appsvc_rg_name
  location            = var.appsvc_region
  service_plan_id     = azurerm_service_plan.appsvc.id

  site_config {}
}
