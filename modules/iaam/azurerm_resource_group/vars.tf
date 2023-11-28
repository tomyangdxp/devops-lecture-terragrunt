# Input variables for Resource Group module

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

variable "name" {
  type        = string
  default     = "iaam"
  description = "The name which should be used for this Resource Group."
}