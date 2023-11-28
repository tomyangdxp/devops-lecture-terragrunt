# Input variables for VM Data Disk module

variable "virtual_machines" {
  description = "The list of virtual machines"
  type = list(object({
    id = string
    name = string
  }))
  default = []
}

variable "virtual_disks" {
  description = "The list of virtual disks"
  type = list(object({
    id = string
    name = string
  }))
  default = []
}