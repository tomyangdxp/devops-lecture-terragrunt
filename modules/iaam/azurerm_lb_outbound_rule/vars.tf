# Input variables for Load Balancer Outbound Rule module

variable "lb_loadBalanceroutbound_id" {
  type        = string
  description = "The id of the resource group"
}

variable "lb_backend_address_pool_pool1b_id" {
  type        = string
  description = "The id of the network interface"
}