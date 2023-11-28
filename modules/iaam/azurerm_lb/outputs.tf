# Output variables for Load Balancer module

output "loadBalancer_id" {
  value       = azurerm_lb.loadBalancer.id
  description = "Output id of the created Load Balancer"
}

output "loadBalancer_private_ip" {
  value       = azurerm_lb.loadBalancer.frontend_ip_configuration[0].private_ip_address
  description = "Output id of the created Load Balancer"
}

output "loadBalanceroutbound_id" {
  value       = azurerm_lb.loadBalanceroutbound.id
  description = "Output id of the created Load Balancer"
}