# Input variables for DNS Zone Virtual Network Link module

variable "environment" {
  type        = string
  default     = null
  description = "Tags which should be assigned"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "dns_zone_dns_name" {
  type        = string
  description = "The name of the DNS Zone"
}

variable "virtual_network_vnet_id" {
  type        = string
  description = "The id of the virtual network"
}