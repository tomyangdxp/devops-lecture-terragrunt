# This module manages Network Interface App Gateway Backend Pool Association

locals {
  myconfig = tolist([
     {
        "pool_id" = "${var.application_gateway_appg_id}/backendAddressPools/clusterMasterBackendPool"
        "nic_name" = "clustermaster"
     },
     {
        "pool_id" = "${var.application_gateway_appg_id}/backendAddressPools/deploymentServerBackendPool"
        "nic_name" = "ds0"
     },
     {
        "pool_id" = "${var.application_gateway_appg_id}/backendAddressPools/monitoringConsoleBackendPool"
        "nic_name" = "monitoring"
     },
     {
        "pool_id" = "${var.application_gateway_appg_id}/backendAddressPools/searchHeadBackendPool"
        "nic_name" = "sh0"
     },
     {
        "pool_id" = "${var.application_gateway_appg_id}/backendAddressPools/searchHeadBackendPool"
        "nic_name" = "sh1"
     },
     {
        "pool_id" = "${var.application_gateway_appg_id}/backendAddressPools/searchHeadBackendPool"
        "nic_name" = "sh2"
     }
  ])
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "appgbackendpool" {
  for_each            = { for entry in local.myconfig : "${entry.pool_id}.${entry.nic_name}" => entry }
  backend_address_pool_id = each.value.pool_id
  ip_configuration_name   = "ipconfig1"
  network_interface_id    = var.network_interfaces[index(var.network_interfaces.*.name, "${each.value.nic_name}")].id
}
