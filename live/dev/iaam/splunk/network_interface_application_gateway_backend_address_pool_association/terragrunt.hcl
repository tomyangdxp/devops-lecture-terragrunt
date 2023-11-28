# Configuration for Network Interface App Gateway Backend Pool Association

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
  source = "../../../../../modules/iaam/azurerm_network_interface_application_gateway_backend_address_pool_association"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "network_interface" {
  config_path = "../network_interface"
  mock_outputs = {
    nics = [
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/clustermaster"
         "name" = "clustermaster"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/ds0"
         "name" = "ds0"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/indexer0"
         "name" = "indexer0"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/indexer1"
         "name" = "indexer1"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/indexer2"
         "name" = "indexer2"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/licensemaster"
         "name" = "licensemaster"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/monitoring"
         "name" = "monitoring"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/sh0"
         "name" = "sh0"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/sh1"
         "name" = "sh1"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/sh2"
         "name" = "sh2"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkInterfaces/shd"
         "name" = "shd"
      }
    ]
  }
}

dependency "application_gateway" {
  config_path = "../application_gateway"
  mock_outputs = {
    appg_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/applicationGateways/appg_id"
  }
}

# Set the input variables for the Network Interface App Gateway Backend Pool Association module
inputs = {
  application_gateway_appg_id = dependency.application_gateway.outputs.appg_id
  network_interfaces = dependency.network_interface.outputs.nics
}
