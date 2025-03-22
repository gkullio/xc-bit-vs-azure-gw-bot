resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.vnet_address_space]
  tags = {
    Owner = var.owner
    Email = var.owner_email
  }
}

resource "azurerm_subnet" "ext" {
  name                 = var.ext_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.ext_address_space]
}

resource "azurerm_public_ip" "app_gw_pip" {
  name                = var.app_gw_pip_name
  sku                 = "Standard"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = var.app_gw_pip_name
  tags = {
    Owner = var.owner
    Email = var.owner_email
  }
}


