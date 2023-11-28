# This module manages Subnets

locals {
  subnets = {
    "ApplicationGatewaySubnet" = "5.0/24"
    "AzureBastionSubnet" = "4.0/24"
    "forwarders" = "2.0/24"
    "indexer" = "0.0/24"
    "management" = "3.0/24"
    "search" = "1.0/24"
  }
}

resource "azurerm_subnet" "subnet" {
  count = length(local.subnets)
  address_prefixes     = ["${var.network_prefix}.${values(local.subnets)[count.index]}"]
  name                 = "${keys(local.subnets)[count.index]}"
  service_endpoints    = (keys(local.subnets)[count.index] == "ApplicationGatewaySubnet" || keys(local.subnets)[count.index] == "AzureBastionSubnet") ? [] : ["Microsoft.Storage"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
}
