# Output variables for DNS Zone module

output "dns_name" {
  value       = azurerm_private_dns_zone.dns.name
  description = "Output name of the created DNS Zone"
}