resource "random_pet" "loadbalancer" {
  length = 1
}

resource "volterra_http_loadbalancer" "appProxy" {
  name      = "${var.name}-${random_pet.loadbalancer.id}-https-lb"
  namespace = var.namespace

  advertise_on_public_default_vip = true
  disable_api_definition          = true
  no_challenge                    = true

  #domains = ["${var.name}.${var.delegated_dns_domain}"]
  domains = ["${var.name}-${random_pet.loadbalancer.id}.${var.delegated_dns_domain}"]

  #round_robin = true
  source_ip_stickiness = true

############### Uncomment this section if you want to use HTTPS Auto Cert ################
############### Then comment out the http block ################
  #https_auto_cert {
  #  add_hsts             = true
  #  default_loadbalancer = false
  #  port                 = "443"
  #  http_redirect        = true
  #}
##########################################################################################

  http {
    port = 80
    dns_volterra_managed = true
  }


 ############### Attach a Default Pool to the Load Balancer ################
  #default_route_pools {
  #  pool {
  #    namespace = var.namespace
  #    name      = volterra_origin_pool.origin.name
  #  }
  #}
############################################################################

  enable_malicious_user_detection = true
  service_policies_from_namespace = true
  disable_trust_client_ip_headers = true
  user_id_client_ip               = true

  app_firewall {
    name      = volterra_app_firewall.example.name
    namespace = var.namespace
  }

  bot_defense {
    regional_endpoint = "US"
    policy {
      javascript_mode = "ASYNC_JS_NO_CACHING"
      protected_app_endpoints {
        metadata {
          name    = "bot-showcase"
        }
        http_methods = ["METHOD_POST"]
        flow_label {
          authentication {
            login {
              disable_transaction_result = true
            }
          }
        }
        protocol   = "BOTH"
        any_domain = true
        path {
          prefix = "/"
        }
        web = true
        mitigation {
          block {
            status = "OK"
            body   = "string:///VGhlIHJlcXVlc3RlZCBVUkwgd2FzIHJlamVjdGVkIGJ5IERpc3RyaWJ1dGVkIENsb3VkIEJvdCBEZWZlbnNlLiBQbGVhc2UgY29uc3VsdCB3aXRoIHlvdXIgYWRtaW5pc3RyYXRvci4="
          }
        }
      }
      protected_app_endpoints {
        metadata {
          name    = "web-scraping"
        }
        http_methods = ["METHOD_GET_DOCUMENT"]
        flow_label {
          search {
            product_search = true
          }
        }
        protocol   = "BOTH"
        any_domain = true
        path {
          prefix = "/"
        }
        web = true
        mitigation {
          block {
            status = "OK"
            body   = "string:///VGhlIHJlcXVlc3RlZCBVUkwgd2FzIHJlamVjdGVkLCBCb3QhIFBsZWFzZSBjb25zdWx0IHdpdGggeW91ciBhZG1pbmlzdHJhdG9yLg=="
          }
        }
      }
      js_insert_all_pages {
        javascript_location = "AFTER_HEAD"
      }
      js_download_path   = "/common.js"
      disable_mobile_sdk = true
    }
    timeout = "1000"
  }
  
  enable_api_discovery {
    enable_learn_from_redirect_traffic = true
  }

  enable_ip_reputation {
    ip_threat_categories = ["SPAM_SOURCES"]
  }

  data_guard_rules {
    metadata {
      name    = "default-rule"
    }
    apply_data_guard = true
    any_domain       = true
    path {
      prefix = "/"
    }
  }

  client_side_defense {
    policy {
      js_insert_all_pages = true
    }
  }

  disable_bot_defense = true
  enable_threat_mesh = true
  
  more_option {
    request_headers_to_add {
      name   = "geo-country"
      value  = "$[geoip_country]"
      append = false
    }
    request_headers_to_add {
      name   = "Access-Control-Allow-Origin"
      value  = "*"
      append = false
    }
  }
  routes {
    simple_route {
      http_method = "ANY"
      path {
        prefix = "/"
      }
      origin_pools {
        pool {
          namespace = var.namespace
          name      = volterra_origin_pool.origin.name
        }
        weight   = 1
        priority = 1
      }
    }
  }
}