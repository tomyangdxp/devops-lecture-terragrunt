# Output variables for Public IP module

output "appg_id" {
  value       = azurerm_public_ip.appg.id
  description = "Output id of the created Public IP"
}

output "bastion_id" {
  value       = azurerm_public_ip.bastion.id
  description = "Output id of the created Public IP"
}

output "dsOutboundlb_id" {
  value       = azurerm_public_ip.dsOutboundlb.id
  description = "Output id of the created Public IP"
}