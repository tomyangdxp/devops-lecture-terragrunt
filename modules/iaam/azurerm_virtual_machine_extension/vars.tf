# Input variables for VM Extension module

variable "virtual_machines" {
  description = "The list of virtual machines"
  type = list(object({
    id = string
    name = string
  }))
  default = []
}

variable "log_analytics_workspace_analytics_workspace_id" {
  type        = string
  description = "The workspace id of the log analytics workspace"
}

variable "log_analytics_workspace_analytics_workspace_key" {
  type        = string
  description = "The workspace key of the log analytics workspace"
}

variable "splunk_config_url" {
  type        = string
  description = "The url of the splunk config folder"
}

variable "splunk_scripts_url" {
  type        = string
  description = "The url of the splunk scripts folder"
}

variable "splunk_download_url" {
  type        = string
  description = "The url of the splunk installer"
}

variable "splunk_dns_zone" {
  type        = string
  description = "The name of the dns zone"
}

variable "lb_loadBalancer_private_ip" {
  type        = string
  description = "The private ip of the load balancer"
}