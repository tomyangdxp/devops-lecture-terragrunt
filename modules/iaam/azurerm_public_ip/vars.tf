# Input variables for Public IP module

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

variable "splunk_appg_domain" {
  type        = string
  description = "The domain name of the application gateway"
}

variable "splunk_bastion_domain" {
  type        = string
  description = "The domain name of the bastion host"
}

variable "splunk_dsoutbound_domain" {
  type        = string
  description = "The domain name of the splunker deployer server outbound load balancer"
}