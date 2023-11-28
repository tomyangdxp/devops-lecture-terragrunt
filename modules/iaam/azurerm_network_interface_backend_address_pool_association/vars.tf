# Input variables for Load Balancer Backend Pool Network Interface Association module

variable "lb_backend_address_pool_pool1a_id" {
  type        = string
  description = "The id of the network interface"
}

variable "lb_backend_address_pool_pool1b_id" {
  type        = string
  description = "The id of the network interface"
}

variable "network_interfaces" {
  description = "The list of network interfaces"
  type = list(object({
    id = string
    name = string
  }))
  default = []
}