# This module manages Load Balancer Backend Pool Network Interface Association

resource "azurerm_network_interface_backend_address_pool_association" "nicbackpool1" {
  backend_address_pool_id = var.lb_backend_address_pool_pool1b_id
  ip_configuration_name   = "ipconfig1"
  network_interface_id    = var.network_interfaces[index(var.network_interfaces.*.name, "ds0")].id
}
resource "azurerm_network_interface_backend_address_pool_association" "nicbackpool2" {
  backend_address_pool_id = var.lb_backend_address_pool_pool1a_id
  ip_configuration_name   = "ipconfig1"
  network_interface_id    = var.network_interfaces[index(var.network_interfaces.*.name, "ds0")].id
}