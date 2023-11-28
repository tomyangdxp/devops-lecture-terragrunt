# Output variables for Network Security Group module

output "nsgs" {
  value = [ for nsg in azurerm_network_security_group.nsg[*]:
      {
         id = nsg.id
         name = nsg.name
      }
  ]
}