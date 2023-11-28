# This module manages Network Interfaces

locals {
  myconfig = tolist([
     {
        "vm_name" = "clustermaster"
        "subnet_name" = "management"
     },
     {
        "vm_name" = "ds0"
        "subnet_name" = "management"
     },
     {
        "vm_name" = "indexer0"
        "subnet_name" = "indexer"
     },
     {
        "vm_name" = "indexer1"
        "subnet_name" = "indexer"
     },
     {
        "vm_name" = "indexer2"
        "subnet_name" = "indexer"
     },
     {
        "vm_name" = "licensemaster"
        "subnet_name" = "management"
     },
     {
        "vm_name" = "monitoring"
        "subnet_name" = "management"
     },
     {
        "vm_name" = "sh0"
        "subnet_name" = "search"
     },
     {
        "vm_name" = "sh1"
        "subnet_name" = "search"
     },
     {
        "vm_name" = "sh2"
        "subnet_name" = "search"
     },
     {
        "vm_name" = "shd"
        "subnet_name" = "management"
     }
  ])
}

resource "azurerm_network_interface" "nic" {
  for_each            = { for entry in local.myconfig : "${entry.vm_name}.${entry.subnet_name}" => entry }
  location            = var.location
  name                = "${each.value.vm_name}"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnets[index(var.subnets.*.name, each.value.subnet_name)].id
  }
  tags = {
    environment = var.environment
  }
}
