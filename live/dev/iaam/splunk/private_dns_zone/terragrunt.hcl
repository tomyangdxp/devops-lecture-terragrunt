# Configuration for DNS Zone

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
  splunk_dns_zone = local.splunk_vars.locals.splunk_dns_zone
}

# Specify the path to the source of the module
terraform {
  source = "../../../../../modules/iaam/azurerm_private_dns_zone"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# DNS Zone must be created inside a resource group
dependency "resource_group" {
  config_path = "../resource_group"
  mock_outputs = {
    resource_name = "mockOutput"
  }
}

# Set the input variables for the DNS Zone module
inputs = {
  resource_group_name = dependency.resource_group.outputs.resource_name
  environment = local.env
  splunk_dns_zone = local.splunk_dns_zone
}
