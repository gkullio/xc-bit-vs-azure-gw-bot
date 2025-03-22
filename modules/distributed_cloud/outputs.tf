output "XC_LB_FQDN" {
  value = "http://${volterra_http_loadbalancer.appProxy.domains[0]}"
}
