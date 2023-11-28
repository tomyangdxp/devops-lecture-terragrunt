# This module manages Application Gateway

resource "azurerm_application_gateway" "appg" {
  location            = var.location
  name                = "splunk-appg"
  resource_group_name = var.resource_group_name
  zones               = ["1", "2", "3"]
  autoscale_configuration {
    max_capacity = 10
    min_capacity = 3
  }
  backend_address_pool {
    name = "clusterMasterBackendPool"
  }
  backend_address_pool {
    name = "deploymentServerBackendPool"
  }
  backend_address_pool {
    name = "monitoringConsoleBackendPool"
  }
  backend_address_pool {
    name = "searchHeadBackendPool"
  }
  backend_http_settings {
    cookie_based_affinity = "Enabled"
    name                  = "appGatewayBackendHttpSettings"
    port                  = 8000
    protocol              = "Http"
  }
  backend_http_settings {
    cookie_based_affinity = "Enabled"
    name                  = "appGatewayCmBackendHttpSettings"
    port                  = 8001
    protocol              = "Http"
  }
  backend_http_settings {
    cookie_based_affinity = "Enabled"
    name                  = "appGatewayDsBackendHttpSettings"
    port                  = 8002
    protocol              = "Http"
  }
  backend_http_settings {
    cookie_based_affinity = "Enabled"
    name                  = "appGatewayMonitoringBackendHttpSettings"
    port                  = 8003
    protocol              = "Http"
  }
  frontend_ip_configuration {
    name                 = "appGatewayFrontendIP"
    public_ip_address_id = var.public_ip_address_appg_id
  }
  frontend_ip_configuration {
    name                          = "appGatewayFrontendPrivateIP"
    private_ip_address_allocation = "Static"
    private_ip_address = "${var.network_prefix}.5.5"
    subnet_id                     = var.subnets[index(var.subnets.*.name, "ApplicationGatewaySubnet")].id
  }
  frontend_port {
    name = "appGatewayFrontendClusterMasterPort"
    port = 8001
  }
  frontend_port {
    name = "appGatewayFrontendDeploymentServerPort"
    port = 8002
  }
  frontend_port {
    name = "appGatewayFrontendMonitoringConsolePort"
    port = 8000
  }
  frontend_port {
    name = "appGatewayFrontendPort"
    port = 80
  }
  frontend_port {
    name = "appGatewayPrivateFrontendClusterMasterPort"
    port = 8004
  }
  frontend_port {
    name = "appGatewayPrivateFrontendDeploymentServerPort"
    port = 8005
  }
  frontend_port {
    name = "appGatewayPrivateFrontendMonitoringConsolePort"
    port = 8003
  }
  frontend_port {
    name = "appGatewayPrivateFrontendPort"
    port = 8080
  }
  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnets[index(var.subnets.*.name, "ApplicationGatewaySubnet")].id
  }
  http_listener {
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "appGatewayFrontendClusterMasterPort"
    name                           = "clusterMasterHttpListener"
    protocol                       = "Http"
  }
  http_listener {
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "appGatewayFrontendDeploymentServerPort"
    name                           = "deploymentServerHttpListener"
    protocol                       = "Http"
  }
  http_listener {
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "appGatewayFrontendMonitoringConsolePort"
    name                           = "monitoringConsoleHttpListener"
    protocol                       = "Http"
  }
  http_listener {
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "appGatewayFrontendPort"
    name                           = "searchHeadHttpListener"
    protocol                       = "Http"
  }
  http_listener {
    frontend_ip_configuration_name = "appGatewayFrontendPrivateIP"
    frontend_port_name             = "appGatewayPrivateFrontendClusterMasterPort"
    name                           = "clusterMasterHttpPrivateListener"
    protocol                       = "Http"
  }
  http_listener {
    frontend_ip_configuration_name = "appGatewayFrontendPrivateIP"
    frontend_port_name             = "appGatewayPrivateFrontendDeploymentServerPort"
    name                           = "deploymentServerHttpPrivateListener"
    protocol                       = "Http"
  }
  http_listener {
    frontend_ip_configuration_name = "appGatewayFrontendPrivateIP"
    frontend_port_name             = "appGatewayPrivateFrontendMonitoringConsolePort"
    name                           = "monitoringConsoleHttpPrivateListener"
    protocol                       = "Http"
  }
  http_listener {
    frontend_ip_configuration_name = "appGatewayFrontendPrivateIP"
    frontend_port_name             = "appGatewayPrivateFrontendPort"
    name                           = "searchHeadHttpPrivateListener"
    protocol                       = "Http"
  }
  request_routing_rule {
    backend_address_pool_name  = "clusterMasterBackendPool"
    backend_http_settings_name = "appGatewayCmBackendHttpSettings"
    http_listener_name         = "clusterMasterHttpListener"
    name                       = "clusterMasterRule"
    priority                   = 10050
    rule_type                  = "Basic"
  }
  request_routing_rule {
    backend_address_pool_name  = "clusterMasterBackendPool"
    backend_http_settings_name = "appGatewayCmBackendHttpSettings"
    http_listener_name         = "clusterMasterHttpPrivateListener"
    name                       = "clusterMasterPrivateRule"
    priority                   = 10060
    rule_type                  = "Basic"
  }
  request_routing_rule {
    backend_address_pool_name  = "deploymentServerBackendPool"
    backend_http_settings_name = "appGatewayDsBackendHttpSettings"
    http_listener_name         = "deploymentServerHttpListener"
    name                       = "deploymentServerRule"
    priority                   = 10070
    rule_type                  = "Basic"
  }
  request_routing_rule {
    backend_address_pool_name  = "deploymentServerBackendPool"
    backend_http_settings_name = "appGatewayDsBackendHttpSettings"
    http_listener_name         = "deploymentServerHttpPrivateListener"
    name                       = "deploymentServerPrivateRule"
    priority                   = 10080
    rule_type                  = "Basic"
  }
  request_routing_rule {
    backend_address_pool_name  = "monitoringConsoleBackendPool"
    backend_http_settings_name = "appGatewayMonitoringBackendHttpSettings"
    http_listener_name         = "monitoringConsoleHttpListener"
    name                       = "monitoringConsoleRule"
    priority                   = 10030
    rule_type                  = "Basic"
  }
  request_routing_rule {
    backend_address_pool_name  = "monitoringConsoleBackendPool"
    backend_http_settings_name = "appGatewayMonitoringBackendHttpSettings"
    http_listener_name         = "monitoringConsoleHttpPrivateListener"
    name                       = "monitoringConsolePrivateRule"
    priority                   = 10040
    rule_type                  = "Basic"
  }
  request_routing_rule {
    backend_address_pool_name  = "searchHeadBackendPool"
    backend_http_settings_name = "appGatewayBackendHttpSettings"
    http_listener_name         = "searchHeadHttpListener"
    name                       = "searchHeadRule"
    priority                   = 10010
    rule_type                  = "Basic"
  }
  request_routing_rule {
    backend_address_pool_name  = "searchHeadBackendPool"
    backend_http_settings_name = "appGatewayBackendHttpSettings"
    http_listener_name         = "searchHeadHttpPrivateListener"
    name                       = "searchHeadPrivateRule"
    priority                   = 10020
    rule_type                  = "Basic"
  }
  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
  }
  tags = {
    environment = var.environment
  }
}