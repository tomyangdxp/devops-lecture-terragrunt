# Output variables for Virtual Machine module

output "vms" {
  value = [ for vm in azurerm_linux_virtual_machine.vm:
      {
         id = vm.id
         name = vm.name
      }
  ]
}