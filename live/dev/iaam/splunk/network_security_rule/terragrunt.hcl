# Configuration for Network Security Rules

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
  source = "../../../../../modules/iaam/azurerm_network_security_rule"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# Network Security Rules must be created inside a resource group
dependency "resource_group" {
  config_path = "../resource_group"
  mock_outputs = {
    resource_name = "mockOutput"
  }
}

dependency "network_security_group" {
  config_path = "../network_security_group"
  mock_outputs = {
    nsgs = [
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkSecurityGroups/appg"
         "name" = "appg"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkSecurityGroups/bastion"
         "name" = "bastion"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/networkSecurityGroups/splunk"
         "name" = "splunk"
      }
    ]
  }
}

# Set the input variables for the Network Security Rules module
inputs = {
  resource_group_name = dependency.resource_group.outputs.resource_name
  nsgs = dependency.network_security_group.outputs.nsgs
}
