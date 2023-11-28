# This module manages network security group association

locals {
  subnetnsg = {
    "ApplicationGatewaySubnet" = "appg"
    "AzureBastionSubnet" = "bastion"
    "forwarders" = "splunk"
    "indexer" = "splunk"
    "management" = "splunk"
    "search" = "splunk"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsga" {
  count = length(local.subnetnsg)
  network_security_group_id = var.nsgs[index(var.nsgs.*.name, values(local.subnetnsg)[count.index] )].id
  subnet_id                 = var.subnets[index(var.subnets.*.name, keys(local.subnetnsg)[count.index] )].id
}
