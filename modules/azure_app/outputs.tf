output "service_plan_name" {
  value = azurerm_service_plan.asp.name
}

output "web_app_name" {
  value = azurerm_linux_web_app.linux_webapp.name
}

output "web_app_hostname" {
  value = azurerm_linux_web_app.linux_webapp.default_hostname
}

output "default_hostname_full_url" {
  value = "https://${azurerm_linux_web_app.linux_webapp.default_hostname}"
}