# Output variables for Log Analytics Workspace module

output "analytics_id" {
  value       = azurerm_log_analytics_workspace.analytics.id
  description = "Output id of the created Log Analytics Workspace"
}

output "analytics_workspace_id" {
  value       = azurerm_log_analytics_workspace.analytics.workspace_id
  description = "Output workspace id of the created Log Analytics Workspace"
}

output "analytics_workspace_key" {
  value       = nonsensitive(azurerm_log_analytics_workspace.analytics.primary_shared_key)
  description = "Output key of the created Log Analytics Workspace"
}