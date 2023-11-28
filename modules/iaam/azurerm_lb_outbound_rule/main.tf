# This module manages Load Balancer Outbound Rule

resource "azurerm_lb_outbound_rule" "example" {
  name                    = "OutboundRule"
  loadbalancer_id         = var.lb_loadBalanceroutbound_id
  protocol                = "Tcp"
  backend_address_pool_id = var.lb_backend_address_pool_pool1b_id

  frontend_ip_configuration {
    name = "LoadBalancerOutboundFrontEnd"
  }
}