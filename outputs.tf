output "Azure_resources" {
  value = {
    resource_group_name       = azurerm_resource_group.rg.name,
    resource_group_portal_url = "https://portal.azure.com/#@/resource/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.rg.name}/overview",

    waf_policy_name           = module.azure_app_gateway.firewall_policy_name,
    waf_policy_portal_url     = "https://portal.azure.com/#@/resource/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.rg.name}/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/${module.azure_app_gateway.firewall_policy_name}/overview",
  }
}

output "Links_to_Azure_and_Distributed_Cloud_proxies" {
  value = {
    "Distributed Cloud FQDN"  = module.distributed-cloud.XC_LB_FQDN,
    
    "Azure App Gateway FQDN"  = "http://${module.azure-vnet.app_gw_pip_ip_fqdn}"
  }
}

output "Direct_ink_to_Azure_Web_App--NO_SECURITY" {
  value = {
    Azure_web-app_URL         = "http://${module.azure-web-app.default_hostname_full_url}"
  }
}