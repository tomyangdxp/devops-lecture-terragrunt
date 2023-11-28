# This module manages public ips

resource "azurerm_public_ip" "appg" {
  allocation_method   = "Static"
  domain_name_label   = var.splunk_appg_domain
  location            = var.location
  name                = "appg"
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  tags = {
    environment = var.environment
  }
}

resource "azurerm_public_ip" "bastion" {
  allocation_method   = "Static"
  domain_name_label   = var.splunk_bastion_domain
  location            = var.location
  name                = "bastion"
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  tags = {
    environment = var.environment
  }
}

resource "azurerm_public_ip" "dsOutboundlb" {
  allocation_method   = "Static"
  domain_name_label   = var.splunk_dsoutbound_domain
  location            = var.location
  name                = "dsOutboundlb"
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  tags = {
    environment = var.environment
  }
}