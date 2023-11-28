locals {
  location_vars = read_terragrunt_config(find_in_parent_folders("location.hcl"))
  env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  global_vars   = read_terragrunt_config(find_in_parent_folders("global.hcl"))

  location = local.location_vars.locals.location
  env      = local.env_vars.locals.env
  suffix   = local.env_vars.locals.suffix
  project  = local.global_vars.locals.project
}

# Specify the path to the source of the module
terraform {
  source = "../../../../../modules/reactdemo/azurerm_storage_account_static_website_content"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# define dependency on modules and their outputs
dependency "storage_account" {
  config_path = "../static-site"
  mock_outputs = {
    name = "mockoutput"
  }
}

# Set inputs to pass as variables to the module
inputs = {
  storage_account_name = dependency.storage_account.outputs.name
}
