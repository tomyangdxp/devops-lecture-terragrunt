# Input variables for Log Analytics Solution module

variable "environment" {
  type        = string
  default     = null
  description = "Tags which should be assigned"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "The azure region"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "log_analytics_workspace_analytics_id" {
  type        = string
  description = "The id of the log analytics workspace"
}