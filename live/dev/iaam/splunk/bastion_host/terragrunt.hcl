# Configuration for Bastion Host

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
  source = "../../../../../modules/iaam/azurerm_bastion_host"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# Bastion Host must be created inside a resource group
dependency "resource_group" {
  config_path = "../resource_group"
  mock_outputs = {
    resource_name = "mockOutput"
  }
}

dependency "subnet" {
  config_path = "../subnet"
  mock_outputs = {
    subnets = [
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/virtualNetworks/splunkvnet/subnets/ApplicationGatewaySubnet"
         "name" = "ApplicationGatewaySubnet"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/virtualNetworks/splunkvnet/subnets/AzureBastionSubnet"
         "name" = "AzureBastionSubnet"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/virtualNetworks/splunkvnet/subnets/forwarders"
         "name" = "forwarders"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/virtualNetworks/splunkvnet/subnets/indexer"
         "name" = "indexer"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/virtualNetworks/splunkvnet/subnets/management"
         "name" = "management"
      },
      {
         "id" = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/virtualNetworks/splunkvnet/subnets/search"
         "name" = "search"
      }
    ]
  }
}

dependency "public_ip" {
  config_path = "../public_ip"
  mock_outputs = {
    appg_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/publicIPAddresses/appg_id"
    bastion_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/publicIPAddresses/bastion_id"
    dsOutboundlb_id = "/subscriptions/787821f3-252d-451a-9420-7e53ecfd2bd6/resourceGroups/splunktest/providers/Microsoft.Network/publicIPAddresses/dsOutboundlb_id"
  }
}


# Set the input variables for the Bastion Host module
inputs = {
  location            = local.location
  resource_group_name = dependency.resource_group.outputs.resource_name
  environment = local.env
  public_ip_address_bastion_id = dependency.public_ip.outputs.bastion_id
  subnets = dependency.subnet.outputs.subnets
}
