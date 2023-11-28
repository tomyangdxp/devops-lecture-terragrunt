# Configuration for Virtual Machine Extensions

locals {
  # Automatically load environment-level variables from files in parent folders
  location_vars = read_terragrunt_config(find_in_parent_folders("location.hcl"))
  env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  splunk_vars   = read_terragrunt_config(find_in_parent_folders("splunk.hcl"))
  global_vars   = read_terragrunt_config(find_in_parent_folders("global.hcl"))

  # Extract out common variables for reuse
  location = local.location_vars.locals.location
  env      = local.env_vars.locals.env
  suffix   = local.env_vars.locals.suffix
  project  = local.global_vars.locals.project
  splunk_config_url = local.splunk_vars.locals.splunk_config_url
  splunk_scripts_url = local.splunk_vars.locals.splunk_scripts_url
  splunk_download_url = local.splunk_vars.locals.splunk_download_url
  splunk_dns_zone = local.splunk_vars.locals.splunk_dns_zone
}

# Specify the path to the source of the module
terraform {
  source = "../../../../../modules/iaam/azurerm_virtual_machine_extension"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
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

dependency "lb" {
  config_path = "../lb"
  mock_outputs = {
    loadBalancer_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/loadBalancers/loadBalancer_id"
    loadBalancer_private_ip = "10.0.3.3"
    loadBalanceroutbound_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/loadBalancers/loadBalanceroutbound_id"
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

# Set the input variables for the Virtual Machine Extension module
inputs = {
  splunk_config_url = local.splunk_config_url
  splunk_scripts_url = local.splunk_scripts_url
  splunk_download_url = local.splunk_download_url
  splunk_dns_zone = local.splunk_dns_zone
  virtual_machines = dependency.linux_virtual_machine.outputs.vms
  log_analytics_workspace_analytics_workspace_id = dependency.log_analytics_workspace.outputs.analytics_workspace_id
  log_analytics_workspace_analytics_workspace_key = dependency.log_analytics_workspace.outputs.analytics_workspace_key
  lb_loadBalancer_private_ip = dependency.lb.outputs.loadBalancer_private_ip
}
