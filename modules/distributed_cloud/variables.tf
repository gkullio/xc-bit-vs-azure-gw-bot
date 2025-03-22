########################### VARIABLES ####################################
variable "namespace" {
  description = "The namespace in which resources are created"
  type        = string
}

variable "name" {
  description = "The base name for resources"
  type        = string
}

variable "delegated_dns_domain" {
  description = "The delegated DNS domain used for constructing resource hostnames"
  type        = string
}

variable "tenant" {
  description = "The tenant ID used to construct the Volterra API URL"
  type        = string
}

variable "web_app_name" {}
