# Configuration for Virtual Network

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
  source = "../../../../../modules/iaam/azurerm_virtual_network"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# Virtual Network must be created inside a resource group
dependency "resource_group" {
  config_path = "../resource_group"
  mock_outputs = {
    resource_name = "mockOutput"
  }
}

# Set the input variables for the Virtual Network module
inputs = {
  location            = local.location
  resource_group_name = dependency.resource_group.outputs.resource_name
  environment = local.env
  network_prefix = local.network_prefix
}
