# Configuration for Load Balancer Rule

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
  source = "../../../../../modules/iaam/azurerm_lb_rule"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "lb" {
  config_path = "../lb"
  mock_outputs = {
    loadBalancer_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/loadBalancers/loadBalancer_id"
    loadBalancer_private_ip = "10.0.3.3"
    loadBalanceroutbound_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/loadBalancers/loadBalanceroutbound_id"
  }
}

# Set the input variables for the Load Balancer Rule module
inputs = {
  lb_loadBalancer_id = dependency.lb.outputs.loadBalancer_id
}
