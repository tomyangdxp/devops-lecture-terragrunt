# Output variables for Application Gateway module

output "appg_id" {
  value       = azurerm_application_gateway.appg.id
  description = "Output id of the created Application Gateway"
}