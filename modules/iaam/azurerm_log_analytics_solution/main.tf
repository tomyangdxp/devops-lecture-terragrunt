# This module manages Log Analytics Solution

resource "azurerm_log_analytics_solution" "solution" {
  location              = var.location
  resource_group_name   = var.resource_group_name
  solution_name         = "VMInsights"
  workspace_name        = "splunk"
  workspace_resource_id = var.log_analytics_workspace_analytics_id
  plan {
    product   = "OMSGallery/VMInsights"
    publisher = "Microsoft"
  }
  tags = {
    environment = var.environment
  }
}
