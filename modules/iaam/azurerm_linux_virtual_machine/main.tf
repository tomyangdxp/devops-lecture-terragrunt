# This module manages Virtual Machines

locals {
  myconfig = tolist([
     {
        "vm_name" = "clustermaster"
        "zone" = 1
     },
     {
        "vm_name" = "ds0"
        "zone" = 1
     },
     {
        "vm_name" = "indexer0"
        "zone" = 1
     },
     {
        "vm_name" = "indexer1"
        "zone" = 2
     },
     {
        "vm_name" = "indexer2"
        "zone" = 3
     },
     {
        "vm_name" = "licensemaster"
        "zone" = 1
     },
     {
        "vm_name" = "monitoring"
        "zone" = 1
     },
     {
        "vm_name" = "sh0"
        "zone" = 1
     },
     {
        "vm_name" = "sh1"
        "zone" = 2
     },
     {
        "vm_name" = "sh2"
        "zone" = 3
     },
     {
        "vm_name" = "shd"
        "zone" = 1
     }
  ])
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each              = { for entry in local.myconfig : "${entry.vm_name}.${entry.zone}" => entry }
  admin_username        = "splunkadmin"
  location              = var.location
  name                  = each.value.vm_name
  network_interface_ids = [var.network_interfaces[index(var.network_interfaces.*.name, "${each.value.vm_name}")].id]
  resource_group_name   = var.resource_group_name
  size                  = "Standard_D2ds_v4"
  zone                  = "${each.value.zone}"
  admin_ssh_key {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9JiWxG0k7PLLQGSZcfCgjeVIGe3sAKOs+VsPn40zkkLmDg3e0ju8D/M5s0pqSaFRB3lBh9a1jeivdKEHtRq/csMdPVctPcEO/pKSU3holhaRqHGN2nEYDYlIun+1DCD1beBW+typA+GSHQtwALuu0nrsA++TwySyLe6qALXo6FwoL1usQSd4ot0xgHdHF66XQzj8yjQGArVk80AbDfuzQM7+Nb0i3ugJUwX85EY/TOiNA8JPZ/paetd5P9ibaGUUhF+AoydCQTJj0QSjZ6dTkcW+34q173aPb4xBrZ0c9rVjHCFSSPGarKHwPDrPeOb3PWLIZcSbmoEqwJqSSwJeEXMmn7owglmOwxZ1+cF9oIOyCj2CpVTg4dFqyTs0ZPmzcR7mkTgF1QghJ1Bugfw7e11uHqWeu42idxPRSqXfOUltdCItm2Z0cVLqFbSINzyoh78dEEpZP/CT/9JGZo1tcUBffUvvYMdvD2KX0Fx2otWSYU77d35224XcdxRFjHnc= youremail@xxx.com\n"
    username   = "splunkadmin"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  tags = {
    environment = var.environment
  }
}
