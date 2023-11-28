# This module manages DNS Zone Virtual Network Link

resource "azurerm_private_dns_zone_virtual_network_link" "dnsvnetlink" {
  name                  = "vnet-link"
  private_dns_zone_name = var.dns_zone_dns_name
  registration_enabled  = true
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.virtual_network_vnet_id
  tags = {
    environment = var.environment
  }
}
