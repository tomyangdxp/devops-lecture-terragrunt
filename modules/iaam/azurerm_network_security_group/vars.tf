# Input variables for Virtual Security Group module

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
