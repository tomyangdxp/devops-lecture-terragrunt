# Input variables for Network Interface App Gateway Backend Pool Association module

variable "application_gateway_appg_id" {
  type        = string
  description = "The id of the application gateway"
}

variable "network_interfaces" {
  description = "The list of network interfaces"
  type = list(object({
    id = string
    name = string
  }))
  default = []
}