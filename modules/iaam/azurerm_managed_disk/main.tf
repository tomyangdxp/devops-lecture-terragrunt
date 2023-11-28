# This module manages Resource Group

locals {
  myconfig = tolist([
     {
        "vm_name" = "clustermaster"
        "disk_name" = "DataDisk"
        "zone" = "1"
     },
     {
        "vm_name" = "ds0"
        "disk_name" = "DataDisk"
        "zone" = "1"
     },
     {
        "vm_name" = "indexer0"
        "disk_name" = "DataDisk1"
        "zone" = "1"
     },
     {
        "vm_name" = "indexer0"
        "disk_name" = "DataDisk2"
        "zone" = "1"
     },
     {
        "vm_name" = "indexer0"
        "disk_name" = "DataDisk3"
        "zone" = "1"
     },
     {
        "vm_name" = "indexer1"
        "disk_name" = "DataDisk1"
        "zone" = "2"
     },
     {
        "vm_name" = "indexer1"
        "disk_name" = "DataDisk2"
        "zone" = "2"
     },
     {
        "vm_name" = "indexer1"
        "disk_name" = "DataDisk3"
        "zone" = "2"
     },
     {
        "vm_name" = "indexer2"
        "disk_name" = "DataDisk1"
        "zone" = "3"
     },
     {
        "vm_name" = "indexer2"
        "disk_name" = "DataDisk2"
        "zone" = "3"
     },
     {
        "vm_name" = "indexer2"
        "disk_name" = "DataDisk3"
        "zone" = "3"
     },
     {
        "vm_name" = "licensemaster"
        "disk_name" = "DataDisk"
        "zone" = "1"
     },
     {
        "vm_name" = "monitoring"
        "disk_name" = "DataDisk"
        "zone" = "1"
     },
     {
        "vm_name" = "sh0"
        "disk_name" = "DataDisk"
        "zone" = "1"
     },
     {
        "vm_name" = "sh1"
        "disk_name" = "DataDisk"
        "zone" = "2"
     },
     {
        "vm_name" = "sh2"
        "disk_name" = "DataDisk"
        "zone" = "3"
     },
     {
        "vm_name" = "shd"
        "disk_name" = "DataDisk"
        "zone" = "1"
     }
  ])
}

resource "azurerm_managed_disk" "disk" {
  for_each             = { for entry in local.myconfig : "${entry.vm_name}.${entry.zone}.${entry.disk_name}" => entry }
  create_option        = "Empty"
  location             = var.location
  name                 = "${each.value.vm_name}-${each.value.disk_name}"
  resource_group_name  = var.resource_group_name
  storage_account_type = "Premium_LRS"
  zone                 = "${each.value.zone}"
  disk_size_gb         = "10"
  tags = {
    environment = var.environment
  }
}
