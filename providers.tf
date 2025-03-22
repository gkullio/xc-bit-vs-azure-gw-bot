terraform {
  required_version = ">=0.12"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.00"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.43"
    }
  }
}


provider "azurerm" {
  features {}
    client_id       = var.client_id
    client_secret   = var.client_secret
    tenant_id       = var.tenant_id
    subscription_id = var.subscription_id
}

provider "volterra" {
  api_p12_file     = "kulland-api-creds.p12"
  url              = "https://${var.tenant}.console.ves.volterra.io/api"
}