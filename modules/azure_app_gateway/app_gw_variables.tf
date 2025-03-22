####### Global Variables #########
variable "resource_group_name" {}
variable "location" {}

####### Variables for Application Gateway #########

variable "application_gw_name" {}
variable "gateway_ip_configuration_name" {}
variable "ext_subnet_id" {}
variable "frontend_port_name" {}
variable "frontend_ip_configuration_name" {}
variable "app_gw_pip_id" {}
variable "backend_address_pool_name" {}
variable "web_app_url" {}
variable "http_setting_name" {}
variable "listener_name" {}
variable "request_routing_rule_name" {}
variable "owner" {}
variable "owner_email" {}

####### Variables for Web Application Firewall #########

variable "waf_policy_name" {}
variable "waf_policy_mode" {}