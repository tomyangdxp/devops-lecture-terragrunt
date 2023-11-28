# Output variables for Load Balancer Backend Pool module

output "pool1a_id" {
  value       = azurerm_lb_backend_address_pool.pool1a.id
  description = "Output id of the created Load Balancer Backend Pool"
}

output "pool1b_id" {
  value       = azurerm_lb_backend_address_pool.pool1b.id
  description = "Output id of the created Load Balancer Backend Pool"
}