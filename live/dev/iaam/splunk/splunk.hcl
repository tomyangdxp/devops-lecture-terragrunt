
locals {
  splunk_config_url = "https://splunkd101stg.z13.web.core.windows.net/splunk/config"
  splunk_scripts_url = "https://splunkd101stg.z13.web.core.windows.net/splunk/scripts"
  splunk_download_url = "https://splunkd101stg.z13.web.core.windows.net/splunk/splunk-8.1.0-f57c09e87251-Linux-x86_64.tgz"
  splunk_resource_group_name = "splunk"
  splunk_network_prefix = "192.168"
  splunk_dns_zone = "splunk.azure"
  splunk_appg_domain = "splunk-176e"
  splunk_bastion_domain = "splunk-bastion-176e"
  splunk_dsoutbound_domain = "splunk-ds-outbound-176e"
}