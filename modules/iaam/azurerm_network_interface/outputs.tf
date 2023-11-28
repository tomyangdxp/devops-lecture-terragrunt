# Output variables for Network Interface module

output "nics" {
  value = [ for nic in azurerm_network_interface.nic:
      {
         id = nic.id
         name = nic.name
      }
  ]
}