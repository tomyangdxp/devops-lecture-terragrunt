# Configuration for Log Analytics Solution

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
  source = "../../../../../modules/iaam/azurerm_log_analytics_solution"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# Log Analytics Solution must be created inside a resource group
dependency "resource_group" {
  config_path = "../resource_group"
  mock_outputs = {
    resource_name = "mockOutput"
  }
}

dependency "log_analytics_workspace" {
  config_path = "../log_analytics_workspace"
  mock_outputs = {
    analytics_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.OperationalInsights/workspaces/analytics_id"
    analytics_workspace_id = "b85e5e69-7dd2-46ec-adc1-15b1b2f3ca4d"
    analytics_workspace_key = "15b1b2f3ca4d"
  }
}

# Set the input variables for the Log Analytics Solution module
inputs = {
  location            = local.location
  resource_group_name = dependency.resource_group.outputs.resource_name
  environment = local.env
  log_analytics_workspace_analytics_id = dependency.log_analytics_workspace.outputs.analytics_id
}
