# This module manages Network Security Group

locals {
  nsgs = ["appg", "bastion", "splunk"]
}

resource "azurerm_network_security_group" "nsg" {
  count = length(local.nsgs)
  name                = "${local.nsgs[count.index]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    environment = var.environment
  }
}
