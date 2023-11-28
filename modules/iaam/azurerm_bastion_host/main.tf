# This module manages bastion host

resource "azurerm_bastion_host" "bastion" {
  location            = var.location
  name                = "bastion"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                 = "ipconfig"
    public_ip_address_id = var.public_ip_address_bastion_id
    subnet_id            = var.subnets[index(var.subnets.*.name, "AzureBastionSubnet")].id
  }
  tags = {
    environment = var.environment
  }
}