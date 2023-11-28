# Input variables for DNS Zone module

variable "environment" {
  type        = string
  default     = null
  description = "Tags which should be assigned"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "splunk_dns_zone" {
  type        = string
  description = "The name of the dns zone"
}