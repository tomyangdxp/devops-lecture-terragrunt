# Output variables for Virtual Network module

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Output name of the created Virtual Network"
}

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Output id of the created Virtual Network"
}