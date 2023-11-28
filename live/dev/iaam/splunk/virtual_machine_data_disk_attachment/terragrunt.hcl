# Configuration for VM Data Disks used by the Virtual Machines

locals {
  # Automatically load environment-level variables from files in parent folders
  location_vars = read_terragrunt_config(find_in_parent_folders("location.hcl"))
  env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  global_vars   = read_terragrunt_config(find_in_parent_folders("global.hcl"))

  # Extract out common variables for reuse
  location = local.location_vars.locals.location
  env      = local.env_vars.locals.env
  suffix   = local.env_vars.locals.suffix
  project  = local.global_vars.locals.project

}

# Specify the path to the source of the module
terraform {
  source = "../../../../../modules/iaam/azurerm_virtual_machine_data_disk_attachment"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "managed_disk" {
  config_path = "../managed_disk"
  mock_outputs = {
    disks = [
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/clustermaster-DataDisk"
         "name" = "clustermaster-DataDisk"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/ds0-DataDisk"
         "name" = "ds0-DataDisk"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/indexer0-DataDisk1"
         "name" = "indexer0-DataDisk1"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/indexer0-DataDisk2"
         "name" = "indexer0-DataDisk2"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/indexer0-DataDisk3"
         "name" = "indexer0-DataDisk3"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/indexer1-DataDisk1"
         "name" = "indexer1-DataDisk1"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/indexer1-DataDisk2"
         "name" = "indexer1-DataDisk2"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/indexer1-DataDisk3"
         "name" = "indexer1-DataDisk3"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/indexer2-DataDisk1"
         "name" = "indexer2-DataDisk1"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/indexer2-DataDisk2"
         "name" = "indexer2-DataDisk2"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/indexer2-DataDisk3"
         "name" = "indexer2-DataDisk3"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/licensemaster-DataDisk"
         "name" = "licensemaster-DataDisk"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/monitoring-DataDisk"
         "name" = "monitoring-DataDisk"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/sh0-DataDisk"
         "name" = "sh0-DataDisk"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/sh1-DataDisk"
         "name" = "sh1-DataDisk"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/sh2-DataDisk"
         "name" = "sh2-DataDisk"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/disks/shd-DataDisk"
         "name" = "shd-DataDisk"
      }
    ]
  }
}

dependency "linux_virtual_machine" {
  config_path = "../linux_virtual_machine"
  mock_outputs = {
    vms = [
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/clustermaster"
         "name" = "clustermaster"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/ds0"
         "name" = "ds0"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/indexer0"
         "name" = "indexer0"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/indexer1"
         "name" = "indexer1"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/indexer2"
         "name" = "indexer2"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/licensemaster"
         "name" = "licensemaster"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/monitoring"
         "name" = "monitoring"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/sh0"
         "name" = "sh0"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/sh1"
         "name" = "sh1"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/sh2"
         "name" = "sh2"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Compute/virtualMachines/shd"
         "name" = "shd"
      }
    ]
  }
}

# Set the input variables for the VM Data Disk module
inputs = {
  virtual_machines = dependency.linux_virtual_machine.outputs.vms
  virtual_disks = dependency.managed_disk.outputs.disks
}
