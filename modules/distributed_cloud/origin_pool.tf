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
  port = 443

  use_tls {
    use_host_header_as_sni = false
    tls_config {
      default_security  = true
    }
    skip_server_verification = true
    no_mtls                  = true
  }
}