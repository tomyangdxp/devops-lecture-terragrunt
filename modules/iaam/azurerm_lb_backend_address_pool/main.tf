# This module manages Load Balancer Backend Pool

resource "azurerm_lb_backend_address_pool" "pool1a" {
  loadbalancer_id = var.lb_loadBalancer_id
  name            = "LoadBalancerBackEndPool1"
}

resource "azurerm_lb_backend_address_pool" "pool1b" {
  loadbalancer_id = var.lb_loadBalanceroutbound_id
  name            = "LoadBalancerBackEndPool1"
}