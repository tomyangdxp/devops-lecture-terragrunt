# Input variables for Subnet module

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "network_prefix" {
  type        = string
  description = "The prefix of the network"
}