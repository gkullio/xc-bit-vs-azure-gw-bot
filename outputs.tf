output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
output "service_plan_name" {
  value = module.azure-web-app.service_plan_name
}
output "web_app_name" {
  value = module.azure-web-app.web_app_name
}
output "azure-default_hostname" {
  value = module.azure-web-app.default_hostname_full_url
}
output "XC_LB_FQDN" {
  value = module.distributed-cloud.XC_LB_FQDN
}
output "Azure_App_Gateway_FQDN" {
  value = "http://${module.azure-vnet.app_gw_pip_ip_fqdn}"
}