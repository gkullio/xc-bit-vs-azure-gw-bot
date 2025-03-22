resource "random_id" "random_id" {
  byte_length = 1
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}-${random_id.random_id.dec}"
  location = var.location
}

module "azure-web-app" {
    depends_on              = [ azurerm_resource_group.rg ]
    source                  = "./modules/azure_app"
    resource_group_name     = azurerm_resource_group.rg.name
    location                = var.location
    service_plan_name       = var.service_plan_name
    os                      = var.os
    app_service_sku_name    = var.app_service_sku_name
    web_app_name            = "${var.web_app_name}-${random_id.random_id.dec}"
    public_access           = var.public_access
    always_on               = var.always_on
    ip_addr_vpn             = var.ip_addr_vpn
    ip_addr_home            = var.ip_addr_home
    ip_addr_RE_1            = var.ip_addr_RE_1
    ip_addr_RE_2            = var.ip_addr_RE_2 
    ip_addr_RE_3            = var.ip_addr_RE_3
    ip_addr_RE_4            = var.ip_addr_RE_4
    ip_addr_RE_5            = var.ip_addr_RE_5
    ip_addr_RE_6            = var.ip_addr_RE_6
    ip_addr_RE_7            = var.ip_addr_RE_7
    ip_addr_RE_8            = var.ip_addr_RE_8
    ip_addr_RE_9            = var.ip_addr_RE_9
    ip_addr_RE_10           = var.ip_addr_RE_10
    ip_addr_RE_11           = var.ip_addr_RE_11
    docker_image_name       = var.docker_image_name
    owner                   = var.owner
    owner_email             = var.owner_email
}

module "distributed-cloud" {
    source                  = "./modules/distributed_cloud"
    namespace               = var.namespace
    name                    = "${var.name}-${random_id.random_id.dec}"
    delegated_dns_domain    = var.delegated_dns_domain
    tenant                  = var.tenant
    pool-name               = var.pool-name
    web_app_name            = module.azure-web-app.web_app_name
}

module "azure-vnet" {
    depends_on              = [ azurerm_resource_group.rg ]
    source                  = "./modules/azure-vnet"
    resource_group_name     = azurerm_resource_group.rg.name
    location                = var.location
    vnet_name               = "${var.vnet_name}-${random_id.random_id.dec}"
    vnet_address_space      = var.vnet_address_space
    mgmt_subnet_name        = "${var.mgmt_subnet_name}-${random_id.random_id.dec}"
    mgmt_address_space      = var.mgmt_address_space
    ext_subnet_name         = "${var.ext_subnet_name}-${random_id.random_id.dec}"
    ext_address_space       = var.ext_address_space
    int_subnet_name         = "${var.int_subnet_name}-${random_id.random_id.dec}"
    int_address_space       = var.int_address_space 
    app_gw_pip_name         = var.app_gw_pip_name
    owner                   = var.owner
    owner_email             = var.owner_email
}

module "azure_app_gateway" {
    depends_on                      = [ azurerm_resource_group.rg ]
    source                          = "./modules/azure_app_gateway"
    resource_group_name             = azurerm_resource_group.rg.name
    location                        = var.location
    application_gw_name             = "${var.application_gw_name}-${random_id.random_id.dec}"
    gateway_ip_configuration_name   = var.gateway_ip_configuration_name
    frontend_port_name              = var.frontend_port_name
    frontend_ip_configuration_name  = var.frontend_ip_configuration_name
    backend_address_pool_name       = var.backend_address_pool_name
    http_setting_name               = var.http_setting_name
    listener_name                   = var.listener_name
    request_routing_rule_name       = var.request_routing_rule_name
    owner                           = var.owner
    owner_email                     = var.owner_email
    ext_subnet_id                   = module.azure-vnet.ext_subnet_id
    app_gw_pip_id                   = module.azure-vnet.app_gw_pip_id
    web_app_url                     = module.azure-web-app.web_app_hostname
    ############
    waf_policy_name = var.waf_policy_name
    waf_policy_mode = var.waf_policy_mode    
}
