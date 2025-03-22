output "vnet_id" {
  description   = "The ID of the virtual network"
  value         = azurerm_virtual_network.vnet.id
}
output "mgmt_subnet_id" {
  description   = "The ID of the management subnet"
  value         = azurerm_subnet.mgmt.id
}
output "int_subnet_id" {
  description   = "The ID of the internal subnet"
  value         = azurerm_subnet.int.id
}
output "ext_subnet_id" {
  description   = "The ID of the external subnet"
  value         = azurerm_subnet.ext.id
}
output "app_gw_pip_id" {
  description   = "The ID of the Application Gateway public IP"
  value         = azurerm_public_ip.app_gw_pip.id
}
output "app_gw_pip_ip_fqdn" {
  description   = "The FQDN of the Application Gateway public IP"
  value         = azurerm_public_ip.app_gw_pip.fqdn
}