# This module manages VM Extension

locals {
  myconfig = tolist([
     {
        "vm_name" = "clustermaster"
        "config_app" = "sudo bash install.sh --role cluster-master --deployment-server ${var.lb_loadBalancer_private_ip} --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --site 1 --dns-zone ${var.splunk_dns_zone} --replication-factor 3 --search-factor 3 --deploy-hec false --pass4symmkey Password123Password123 --hec-token  master"
     },
     {
        "vm_name" = "ds0"
        "config_app" = "sudo bash install.sh --role deployment-server --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --dns-zone ${var.splunk_dns_zone} --indexer-count 3"
     },
     {
        "vm_name" = "indexer0"
        "config_app" = "sudo bash install.sh --role indexer --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --site 1 --dns-zone ${var.splunk_dns_zone} --pass4symmkey Password123Password123 --indexer-pipelines 2 --vm-sku Standard_D8ds_v4"
     },
     {
        "vm_name" = "indexer1"
        "config_app" = "sudo bash install.sh --role indexer --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --site 2 --dns-zone ${var.splunk_dns_zone} --pass4symmkey Password123Password123 --indexer-pipelines 2 --vm-sku Standard_D8ds_v4"
     },
     {
        "vm_name" = "indexer2"
        "config_app" = "sudo bash install.sh --role indexer --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --site 3 --dns-zone ${var.splunk_dns_zone} --pass4symmkey Password123Password123 --indexer-pipelines 2 --vm-sku Standard_D8ds_v4"
     },
     {
        "vm_name" = "licensemaster"
        "config_app" = "sudo bash install.sh --role license-master --deployment-server ${var.lb_loadBalancer_private_ip} --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --site 1 --license-file PD94bWwgdmVyc2lvbj1cIjEuMFwiIGVuY29kaW5nPVwiVVRGLThcIj8+IDxsaWNlbnNlPiAgIDxzaWduYXR1cmU+STgxbXMzL3N1S2NhT1krQkdKOFVQREo4WG1mNHR3OCtrNDZzbXhwY0hxeko2V1B0ZzZOQTZ0TVVIWHVRNks5MjUwUzc0ZXlYTmhYeDhWVjE5WVpFNVNGNXB1TkhMR2dCSE1mN2w1SnRHcjRsK2YyZmRSS2w4Zm03aDF2IDFMRStTRURwb21DMWhlR3JTc2ZyRCtSRjBJQkpLbzdPUnpDYTVYMFM2UThjZ3JiK2ZqUTJvbWlJekwzMHRJZkZlUW5LQ2p1bkRVVGVIZktzc3RnMFloL2VSOHpGalVCVlhRTXUyR3U0dEFYR21WY0RtRGdNb2cwRXNyeFdIWEhpUDJhUm83MHAgaW5MU1N4akx3YVUwSy9XdVZtWTF1SzVUWFRnaG8xeEMxMXZOb3VRaGJSazh5bDFTTlJETGpWaGYwZ0h2ZnJYY3ozV1Fqc211Z3AwUisxOG9KbUE9PTwvc2lnbmF0dXJlPiAgIDxwYXlsb2FkPiAgICAgPHR5cGU+ZG93bmxvYWQtdHJpYWw8L3R5cGU+ICAgICA8Z3JvdXBfaWQ+VHJpYWw8L2dyb3VwX2lkPiAgICAgPHF1b3RhPjUyNDI4ODAwMDwvcXVvdGE+ICAgICA8bWF4X3Zpb2xhdGlvbnM+NTwvbWF4X3Zpb2xhdGlvbnM+ICAgICA8d2luZG93X3BlcmlvZD4zMDwvd2luZG93X3BlcmlvZD4gICAgIDxjcmVhdGlvbl90aW1lPjE1NzEwMzY0MDA8L2NyZWF0aW9uX3RpbWU+ICAgICA8bGFiZWw+U3BsdW5rIEVudGVycHJpc2UgICBTcGx1bmsgQW5hbHl0aWNzIGZvciBIYWRvb3AgRG93bmxvYWQgVHJpYWw8L2xhYmVsPiAgICAgPHJlbGF0aXZlX2V4cGlyYXRpb25faW50ZXJ2YWw+NTE4NDAwMDwvcmVsYXRpdmVfZXhwaXJhdGlvbl9pbnRlcnZhbD4gICAgIDxhYnNvbHV0ZV9leHBpcmF0aW9uX3RpbWU+MTg4Njc0MTk5OTwvYWJzb2x1dGVfZXhwaXJhdGlvbl90aW1lPiAgICAgPGZlYXR1cmVzPiAgICAgICA8ZmVhdHVyZT5BdXRoPC9mZWF0dXJlPiAgICAgICA8ZmVhdHVyZT5Gd2REYXRhPC9mZWF0dXJlPiAgICAgICA8ZmVhdHVyZT5SY3ZEYXRhPC9mZWF0dXJlPiAgICAgICA8ZmVhdHVyZT5Mb2NhbFNlYXJjaDwvZmVhdHVyZT4gICAgICAgPGZlYXR1cmU+RGlzdFNlYXJjaDwvZmVhdHVyZT4gICAgICAgPGZlYXR1cmU+UmN2U2VhcmNoPC9mZWF0dXJlPiAgICAgICA8ZmVhdHVyZT5TY2hlZHVsZWRTZWFyY2g8L2ZlYXR1cmU+ICAgICAgIDxmZWF0dXJlPkFsZXJ0aW5nPC9mZWF0dXJlPiAgICAgICA8ZmVhdHVyZT5EZXBsb3lDbGllbnQ8L2ZlYXR1cmU+ICAgICAgIDxmZWF0dXJlPkRlcGxveVNlcnZlcjwvZmVhdHVyZT4gICAgICAgPGZlYXR1cmU+U3BsdW5rV2ViPC9mZWF0dXJlPiAgICAgICA8ZmVhdHVyZT5TaWduaW5nUHJvY2Vzc29yPC9mZWF0dXJlPiAgICAgICA8ZmVhdHVyZT5TeXNsb2dPdXRwdXRQcm9jZXNzb3I8L2ZlYXR1cmU+ICAgICAgIDxmZWF0dXJlPkFsbG93RHVwbGljYXRlS2V5czwvZmVhdHVyZT4gCTwvZmVhdHVyZXM+ICAgICA8YWRkX29ucz4gICAgICAgPGFkZF9vbiBuYW1lPVwiaGFkb29wXCIgdHlwZT1cImV4dGVybmFsX3Jlc3VsdHNfcHJvdmlkZXJcIj4gICAgICAgICA8cGFyYW1ldGVyIGtleT1cImVycF90eXBlXCIgdmFsdWU9XCJyZXBvcnRcIi8+ICAgICAgICAgPHBhcmFtZXRlciBrZXk9XCJtYXhOb2Rlc1wiIHZhbHVlPVwiMjAwXCIvPiAgICAgICA8L2FkZF9vbj4gICAgIDwvYWRkX29ucz4gICAgIDxzb3VyY2V0eXBlcy8+ICAgICA8Z3VpZD42RjQxNkU2MS1CNDBFLTQ2MUMtQTc4Mi1DQkMxODZFOTgxMzM8L2d1aWQ+ICAgPC9wYXlsb2FkPiA8L2xpY2Vuc2U+"
     },
     {
        "vm_name" = "monitoring"
        "config_app" = "sudo bash install.sh --role monitoring-console --deployment-server ${var.lb_loadBalancer_private_ip} --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --dns-zone ${var.splunk_dns_zone} --sh-count 3 --deploy-heavy-forwarders false --heavy-forwarder-count  3 --pass4symmkey Password123Password123"
     },
     {
        "vm_name" = "sh0"
        "config_app" = "sudo bash install.sh --role search-head --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --dns-zone ${var.splunk_dns_zone} --sh-count 3 --pass4symmkey Password123Password123 --site 1 --sh-instance 0"
     },
     {
        "vm_name" = "sh1"
        "config_app" = "sudo bash install.sh --role search-head --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --dns-zone ${var.splunk_dns_zone} --sh-count 3 --pass4symmkey Password123Password123 --site 2 --sh-instance 1"
     },
     {
        "vm_name" = "sh2"
        "config_app" = "sudo bash install.sh --role search-head --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --dns-zone ${var.splunk_dns_zone} --sh-count 3 --pass4symmkey Password123Password123 --site 3 --sh-instance 2"
     },
     {
        "vm_name" = "shd"
        "config_app" = "sudo bash install.sh --role search-head-deployer --deployment-server ${var.lb_loadBalancer_private_ip} --conf-url ${var.splunk_config_url} --splunk-url ${var.splunk_download_url} --splunk-user splunkadmin --splunk-password Password123Password123 --dns-zone ${var.splunk_dns_zone} --sh-count 3 --pass4symmkey Password123Password123 --site 1 --sh-count 3 --indexer-count 3"
     }
  ])
}

resource "azurerm_virtual_machine_extension" "extension1" {
  for_each                   = { for entry in local.myconfig : "${entry.vm_name}.${entry.config_app}" => entry }
  auto_upgrade_minor_version = true
  name                       = "DependencyAgentLinux"
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentLinux"
  type_handler_version       = "9.5"
  virtual_machine_id         = var.virtual_machines[index(var.virtual_machines.*.name, each.value.vm_name)].id
}
resource "azurerm_virtual_machine_extension" "extension2" {
  for_each                   = { for entry in local.myconfig : "${entry.vm_name}.${entry.config_app}" => entry }
  auto_upgrade_minor_version = true
  name                       = "OMSExtension"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  settings                   = "{\"stopOnMultipleConnections\":true,\"workspaceId\":\"${var.log_analytics_workspace_analytics_workspace_id}\"}"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.13"
  virtual_machine_id         = var.virtual_machines[index(var.virtual_machines.*.name, each.value.vm_name)].id
  protected_settings = "{\"workspaceKey\":\"${var.log_analytics_workspace_analytics_workspace_key}\"}"
}
resource "azurerm_virtual_machine_extension" "extension3" {
  for_each                   = { for entry in local.myconfig : "${entry.vm_name}.${entry.config_app}" => entry }
  auto_upgrade_minor_version = true
  name                       = "config-app"
  publisher                  = "Microsoft.Azure.Extensions"
  settings                   = "{\"fileUris\":[\"${var.splunk_scripts_url}/common/install.sh\"]}"
  type                       = "CustomScript"
  type_handler_version       = "2.1"
  virtual_machine_id         = var.virtual_machines[index(var.virtual_machines.*.name, each.value.vm_name)].id
  protected_settings = jsonencode({
    "commandToExecute" = each.value.config_app
  })
}
