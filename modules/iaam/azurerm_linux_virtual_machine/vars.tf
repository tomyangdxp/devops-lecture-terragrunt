# Input variables for Virtual Interface module

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

variable "network_interfaces" {
  description = "The list of network interfaces"
  type = list(object({
    id = string
    name = string
  }))
  default = []
}