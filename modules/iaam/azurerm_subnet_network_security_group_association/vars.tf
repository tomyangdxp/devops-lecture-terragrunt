# Input variables for network security group association module

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "nsgs" {
  description = "The list of network security groups"
  type = list(object({
    id = string
    name = string
  }))
  default = []
}

variable "subnets" {
  description = "The list of subnets"
  type = list(object({
    id = string
    name = string
  }))
  default = []
}