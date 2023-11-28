# Input variables for Virtual Security Rule module

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
