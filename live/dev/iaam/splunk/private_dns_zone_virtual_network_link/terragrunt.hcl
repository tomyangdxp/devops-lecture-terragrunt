# Configuration for DNS Zone Virtual Network Link Record

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
  source = "../../../../../modules/iaam/azurerm_private_dns_zone_virtual_network_link"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# DNS Zone Virtual Network Link must be created inside a resource group
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
    vnet_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/virtualNetworks/vnet_146"
  }
}

dependency "private_dns_zone" {
  config_path = "../private_dns_zone"
  mock_outputs = {
    dns_name="splunk.azure"
  }
}

# Set the input variables for the DNS Zone Virtual Network Link module
inputs = {
  resource_group_name = dependency.resource_group.outputs.resource_name
  environment = local.env
  dns_zone_dns_name = dependency.private_dns_zone.outputs.dns_name
  virtual_network_vnet_id = dependency.virtual_network.outputs.vnet_id
}
