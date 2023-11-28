# This module manages Log Analytics Workspace

resource "azurerm_log_analytics_workspace" "analytics" {
  name                = "splunk"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    environment = var.environment
  }
}
