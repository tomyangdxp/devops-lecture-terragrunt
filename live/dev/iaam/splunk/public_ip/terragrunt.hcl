# Configuration for Public IP

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
  splunk_appg_domain = local.splunk_vars.locals.splunk_appg_domain
  splunk_bastion_domain = local.splunk_vars.locals.splunk_bastion_domain
  splunk_dsoutbound_domain = local.splunk_vars.locals.splunk_dsoutbound_domain
}

# Specify the path to the source of the module
terraform {
  source = "../../../../../modules/iaam/azurerm_public_ip"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# Public IP must be created inside a resource group
dependency "resource_group" {
  config_path = "../resource_group"
  mock_outputs = {
    resource_name = "mockOutput"
  }
}

# Set the input variables for the Public IP module
inputs = {
  location            = local.location
  resource_group_name = dependency.resource_group.outputs.resource_name
  environment = local.env
  splunk_appg_domain = local.splunk_appg_domain
  splunk_bastion_domain = local.splunk_bastion_domain
  splunk_dsoutbound_domain = local.splunk_dsoutbound_domain
}
