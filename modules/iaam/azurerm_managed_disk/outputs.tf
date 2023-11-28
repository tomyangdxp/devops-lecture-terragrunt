# Output variables for Managed Disk module

output "disks" {
  value = [ for disk in azurerm_managed_disk.disk:
      {
         id = disk.id
         name = disk.name
      }
  ]
}