# This module manages Load Balancer

resource "azurerm_lb" "loadBalancer" {
  location            = var.location
  name                = "loadBalancer-ds"
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name  = "LoadBalancerFrontEnd"
    zones = ["1", "2", "3"]
    subnet_id = var.subnets[index(var.subnets.*.name, "management")].id
  }
  tags = {
    environment = var.environment
  }
}
resource "azurerm_lb" "loadBalanceroutbound" {
  location            = var.location
  name                = "loadBalancer-outbound-ds"
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name = "LoadBalancerOutboundFrontEnd"
    public_ip_address_id = var.public_ip_address_dsOutboundlb_id
  }
  tags = {
    environment = var.environment
  }
}
