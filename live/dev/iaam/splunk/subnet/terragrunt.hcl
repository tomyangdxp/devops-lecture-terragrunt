# Configuration for Subnet

locals {
  # Automatically load environment-level variables from files in parent folders
  location_vars = read_terragrunt_config(find_in_parent_folders("location.hcl"))
  env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  global_vars   = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  splunk_vars   = read_terragrunt_config(find_in_parent_folders("splunk.hcl"))

  # Extract out common variables for reuse
  location = local.location_vars.locals.location
  env      = local.env_vars.locals.env
  suffix   = local.env_vars.locals.suffix
  project  = local.global_vars.locals.project
  network_prefix = local.splunk_vars.locals.splunk_network_prefix
}

# Specify the path to the source of the module
terraform {
  source = "../../../../../modules/iaam/azurerm_subnet"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# Subnet must be created inside a resource group
dependency "resource_group" {
  config_path = "../resource_group"
  mock_outputs = {
    resource_name = "mockOutput"
  }
}

dependency "virtual_network" {
  config_path = "../virtual_network"
  mock_outputs = {
    vnet_name = "mockOutput"
    vnet_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/virtualNetworks/vnet"
  }
}

# Set the input variables for the Virtual Network module
inputs = {
  resource_group_name = dependency.resource_group.outputs.resource_name
  virtual_network_name = dependency.virtual_network.outputs.vnet_name
  network_prefix = local.network_prefix
}
