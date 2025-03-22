#################################################################################################

########## Global Variables ##########

# Resource Group Section
variable "rg_name" {}
variable "location" {}

# Owner Information
variable "owner" {}
variable "owner_email" {}

# Azure Credentials
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

#################################################################################################

########## Azure Virtual Network ##########

variable "vnet_name" {}
variable "vnet_address_space" {}
variable "ext_subnet_name" {}
variable "ext_address_space" {}
variable "app_gw_pip_name" {}

#################################################################################################

########## Azure App Service Variables ##########
# This file contains all the variables that are used in the main.tf file.

# Service Plan Section
variable "service_plan_name" {}
variable "os" {}
variable "app_service_sku_name" {}
  # For a list of other SKUs to handle more traffic go here:
  # https://azure.microsoft.com/en-us/pricing/details/app-service/linux/

# Web App Section 
variable "web_app_name" {}
variable "public_access" {}

# Site Config Section
variable "always_on" {}
variable "ip_addr_vpn" {}
variable "ip_addr_home" {}
variable "ip_addr_RE_1" {}
variable "ip_addr_RE_2" {}
variable "ip_addr_RE_3" {}
variable "ip_addr_RE_4" {}
variable "ip_addr_RE_5" {}
variable "ip_addr_RE_6" {}
variable "ip_addr_RE_7" {}
variable "ip_addr_RE_8" {}
variable "ip_addr_RE_9" {}
variable "ip_addr_RE_10" {}
variable "ip_addr_RE_11" {}

# Docker Image Name
variable "docker_image_name" {}

#################################################################################################

########## Azure Application Gateway ##########

variable "application_gw_name" {}
variable "gateway_ip_configuration_name" {}
variable "frontend_port_name" {}
variable "frontend_ip_configuration_name" {}
variable "backend_address_pool_name" {}
variable "http_setting_name" {}
variable "listener_name" {}
variable "request_routing_rule_name" {}

## Variables for Web Application Firewall ##

variable "waf_policy_name" {}
variable "waf_policy_mode" {}


#################################################################################################

########## Distributed Cloud Variables ##########
# This file contains all the variables that are used in the main.tf file.

variable "namespace" {}
variable "name" {}
variable "delegated_dns_domain" {}
variable "tenant" {}
variable "pool-name" {}
