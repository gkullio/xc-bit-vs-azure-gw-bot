resource "volterra_origin_pool" "origin" {
  name      = "${var.namespace}-${random_pet.loadbalancer.id}-pool"
  namespace = var.namespace

  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"

  origin_servers {

    public_name {
      dns_name = "${var.web_app_name}.azurewebsites.net"
    }

    labels = {
      "key1" = "main_origin"
    }
  }
  ########### Uncomment the following block to enable 443 for the origin pool ####################
  ########### Comment out the port = 80 line and the no_tls = true line if 443 is chosen ####################
  # port = 443
  
  port = 80
  no_tls = true

  ########### Uncomment the following block to enable TLS settings for the origin pool ####################
  #use_tls {
  #  use_host_header_as_sni = false
  #  tls_config {
  #    default_security  = true
  #  }
  #  skip_server_verification = true
  #  no_mtls                  = true
  #}
}