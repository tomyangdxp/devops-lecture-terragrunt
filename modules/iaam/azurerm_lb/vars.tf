# Input variables for Load Balancer module

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

variable "public_ip_address_dsOutboundlb_id" {
  type        = string
  description = "The id of the public ip address"
}

variable "subnets" {
  description = "The list of subnets"
  type = list(object({
    id = string
    name = string
  }))
  default = []
}