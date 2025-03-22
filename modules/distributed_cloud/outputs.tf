output "XC_LB_FQDN" {
  value = "https://${volterra_http_loadbalancer.appProxy.domains[0]}"
}
