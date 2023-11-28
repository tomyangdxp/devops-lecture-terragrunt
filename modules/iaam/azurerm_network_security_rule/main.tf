# This module manages Network Security Rules

resource "azurerm_network_security_rule" "rule105" {
  access                      = "Allow"
  description                 = "Access to Splunk via port 80"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  direction                   = "Inbound"
  name                        = "Port_80"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "appg")].name
  priority                    = 125
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "0.0.0.0/0"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "rule106" {
  access                      = "Allow"
  description                 = "Access to Splunk"
  destination_address_prefix  = "*"
  destination_port_range      = "8000-8002"
  direction                   = "Inbound"
  name                        = "Port_8000_2"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "appg")].name
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "0.0.0.0/0"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "rule107" {
  access                      = "Allow"
  description                 = "AppGw required ports"
  destination_address_prefix  = "*"
  destination_port_range      = "65200-65535"
  direction                   = "Inbound"
  name                        = "appGwAdmin"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "appg")].name
  priority                    = 126
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "GatewayManager"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "rule108" {
  access                      = "Allow"
  description                 = "AppGw required ports"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "appGwAdmin2"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "appg")].name
  priority                    = 127
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "AzureLoadBalancer"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "rule110" {
  access                      = "Allow"
  destination_address_prefix  = "AzureCloud"
  destination_port_ranges     = ["443", "80"]
  direction                   = "Outbound"
  name                        = "bastion-azure-out-allow"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "bastion")].name
  priority                    = 120
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "*"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "rule111" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_ranges     = ["443", "4443"]
  direction                   = "Inbound"
  name                        = "bastion-gatewaymanager-in-allow"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "bastion")].name
  priority                    = 120
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "GatewayManager"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "rule112" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_ranges     = ["5701", "8080"]
  direction                   = "Inbound"
  name                        = "bastion-host-communication-in-allow"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "bastion")].name
  priority                    = 110
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule113" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "bastion-https-in-allow"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "bastion")].name
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "Internet"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule114" {
  access                      = "Deny"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "bastion-in-deny"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "bastion")].name
  priority                    = 900
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "*"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule115" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  direction                   = "Outbound"
  name                        = "bastion-internet-out-allow"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "bastion")].name
  priority                    = 130
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "*"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule116" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "bastion-loadbalancer-in-allow"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "bastion")].name
  priority                    = 130
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "AzureLoadBalancer"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule117" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_ranges     = ["22", "3389"]
  direction                   = "Outbound"
  name                        = "bastion-vnet-out-allow"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "bastion")].name
  priority                    = 105
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "*"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule118" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_ranges     = ["5701", "8080"]
  direction                   = "Outbound"
  name                        = "bastion-vnet-vnet-out-allow"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "bastion")].name
  priority                    = 110
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "rule120" {
  access                      = "Allow"
  description                 = "SSH access to VMs"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "Port_22"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "splunk")].name
  priority                    = 200
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "0.0.0.0/0"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule121" {
  access                      = "Allow"
  description                 = "Splunk syslog"
  destination_address_prefix  = "*"
  destination_port_range      = "514"
  direction                   = "Inbound"
  name                        = "Port_514"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "splunk")].name
  priority                    = 160
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "0.0.0.0/0"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule122" {
  access                      = "Allow"
  description                 = "Access to Splunk admin console"
  destination_address_prefix  = "*"
  destination_port_range      = "8000"
  direction                   = "Inbound"
  name                        = "Port_8000"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "splunk")].name
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "0.0.0.0/0"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule123" {
  access                      = "Allow"
  description                 = "Access to HEC"
  destination_address_prefix  = "*"
  destination_port_range      = "8088"
  direction                   = "Inbound"
  name                        = "Port_8088"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "splunk")].name
  priority                    = 126
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "0.0.0.0/0"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule124" {
  access                      = "Allow"
  description                 = "Access to Splunk management port"
  destination_address_prefix  = "*"
  destination_port_range      = "8089"
  direction                   = "Inbound"
  name                        = "Port_8089"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "splunk")].name
  priority                    = 125
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "*"
  source_port_range           = "*"
}
resource "azurerm_network_security_rule" "rule125" {
  access                      = "Allow"
  description                 = "Splunk receiver"
  destination_address_prefix  = "*"
  destination_port_range      = "9997"
  direction                   = "Inbound"
  name                        = "Port_9997"
  network_security_group_name = var.nsgs[index(var.nsgs.*.name, "splunk")].name
  priority                    = 150
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "*"
  source_port_range           = "*"
}