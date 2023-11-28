# This module manages Load Balancer Rule

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = var.lb_loadBalancer_id
  name                           = "LBRule1"
  protocol                       = "Tcp"
  frontend_port                  = 8089
  backend_port                   = 8089
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
}