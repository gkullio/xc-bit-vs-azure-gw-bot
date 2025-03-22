resource "azurerm_application_gateway" "app_gw" {
  name                = var.application_gw_name
  resource_group_name = var.resource_group_name
  location            = var.location
  depends_on = [ azurerm_web_application_firewall_policy.app_gw_waf ]

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration_name
    subnet_id = var.ext_subnet_id
  }

  frontend_port {
    name = var.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = var.app_gw_pip_id
  }

  backend_address_pool {
    name    = var.backend_address_pool_name
    fqdns   = [var.web_app_url]
    }

  backend_http_settings {
    name                                = var.http_setting_name
    cookie_based_affinity               = "Disabled"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 15
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Http"
    require_sni                    = false
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = var.listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.http_setting_name
  }  

  tags = {
    Owner = var.owner
    Email = var.owner_email
  }

  firewall_policy_id = azurerm_web_application_firewall_policy.app_gw_waf.id
}


