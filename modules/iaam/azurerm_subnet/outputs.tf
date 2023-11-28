# Output variables for Subnet module

output "subnets" {
  value = [ for subnet in azurerm_subnet.subnet[*]:
      {
         id = subnet.id
         name = subnet.name
      }
  ]
}