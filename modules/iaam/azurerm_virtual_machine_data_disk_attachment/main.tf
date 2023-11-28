# This module manages VM Data Disk

locals {
  myconfig = tolist([
     {
        "vm_name" = "clustermaster"
        "disk_name" = "DataDisk"
        "lun" = 0
     },
     {
        "vm_name" = "ds0"
        "disk_name" = "DataDisk"
        "lun" = 0
     },
     {
        "vm_name" = "indexer0"
        "disk_name" = "DataDisk1"
        "lun" = 0
     },
     {
        "vm_name" = "indexer0"
        "disk_name" = "DataDisk2"
        "lun" = 1
     },
     {
        "vm_name" = "indexer0"
        "disk_name" = "DataDisk3"
        "lun" = 2
     },
     {
        "vm_name" = "indexer1"
        "disk_name" = "DataDisk1"
        "lun" = 0
     },
     {
        "vm_name" = "indexer1"
        "disk_name" = "DataDisk2"
        "lun" = 1
     },
     {
        "vm_name" = "indexer1"
        "disk_name" = "DataDisk3"
        "lun" = 2
     },
     {
        "vm_name" = "indexer2"
        "disk_name" = "DataDisk1"
        "lun" = 0
     },
     {
        "vm_name" = "indexer2"
        "disk_name" = "DataDisk2"
        "lun" = 1
     },
     {
        "vm_name" = "indexer2"
        "disk_name" = "DataDisk3"
        "lun" = 2
     },
     {
        "vm_name" = "licensemaster"
        "disk_name" = "DataDisk"
        "lun" = 0
     },
     {
        "vm_name" = "monitoring"
        "disk_name" = "DataDisk"
        "lun" = 0
     },
     {
        "vm_name" = "sh0"
        "disk_name" = "DataDisk"
        "lun" = 0
     },
     {
        "vm_name" = "sh1"
        "disk_name" = "DataDisk"
        "lun" = 0
     },
     {
        "vm_name" = "sh2"
        "disk_name" = "DataDisk"
        "lun" = 0
     },
     {
        "vm_name" = "shd"
        "disk_name" = "DataDisk"
        "lun" = 0
     }
  ])
}

resource "azurerm_virtual_machine_data_disk_attachment" "vmdisk" {
  for_each           = { for entry in local.myconfig : "${entry.vm_name}.${entry.disk_name}.${entry.lun}" => entry }
  caching            = "ReadWrite"
  lun                = each.value.lun
  managed_disk_id    = var.virtual_disks[index(var.virtual_disks.*.name, "${each.value.vm_name}-${each.value.disk_name}")].id
  virtual_machine_id = var.virtual_machines[index(var.virtual_machines.*.name, each.value.vm_name)].id
}
