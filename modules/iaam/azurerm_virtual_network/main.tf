# This module manages Virtual Network

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["${var.network_prefix}.0.0/16"]
  location            = var.location
  name                = "splunkvnet"
  resource_group_name = var.resource_group_name
  tags = {
    environment = var.environment
  }
}
