# Resource Group Section
variable "resource_group_name" {}
variable "location" {}

# Azure Credentials
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

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

# tags
variable "owner" {}
variable "owner_email" {}