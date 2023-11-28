# This module manages DNS Zone

resource "azurerm_private_dns_zone" "dns" {
  name                = "splunk.azure"
  resource_group_name = var.resource_group_name
  tags = {
    environment = var.environment
  }
}
