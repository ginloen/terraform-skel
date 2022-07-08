#create random 5-digit integer
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

#create storage account
resource "azurerm_storage_account" "storage_account" {
  name                     = "${lower(var.naming_prefix_sa)}${random_integer.ri.result}"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "${lower(var.naming_prefix_sc)}-${var.environment}"
  storage_account_name  = azurerm_storage_account.storage_account.name

}

data "azurerm_storage_account_sas" "storage_acct_info" {
  connection_string = azurerm_storage_account.storage_account.primary_connection_string
  https_only        = true

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = timestamp()
  #change the expiry of the sas token accordingly
  expiry = timeadd(timestamp(), "2190h")

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = true
    process = false
    tag     = false
    filter   = false
  }
}

#acquire storage account and storage container information for remote backend configuration
resource "local_file" "remote_backend_conf" {
  depends_on = [azurerm_storage_container.storage_container]

  filename = "${path.module}/remote_backend.conf"
  content  = <<EOF
storage_account_name = "${azurerm_storage_account.storage_account.name}"
container_name = "${lower(var.naming_prefix_sc)}-${var.environment}"
key = "${var.environment}.terraform.tfstate"
sas_token = "${data.azurerm_storage_account_sas.storage_acct_info.sas}"
  EOF
}