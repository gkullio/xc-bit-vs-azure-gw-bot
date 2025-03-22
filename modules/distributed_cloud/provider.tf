terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.43"
    }
  }
}

#provider "volterra" {
#  api_p12_file     = "../demo_app/kulland-api-creds.p12"
#  url              = "https://${var.tenant}.console.ves.volterra.io/api"
#}