####Create a service plan. "asp"
resource "azurerm_service_plan" "asp" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os
  sku_name            = var.app_service_sku_name
  # For a list of other SKUs to handle more traffic go here:
  # https://azure.microsoft.com/en-us/pricing/details/app-service/linux/
}

locals {
  ip_address_list = concat(
    [
      { ip_add = var.ip_addr_vpn,  priority = "100" },
      { ip_add = var.ip_addr_home, priority = "101" },
    ],
    [
      for i in range(1, 12) : {
        ip_add = lookup({
          1  = var.ip_addr_RE_1,
          2  = var.ip_addr_RE_2,
          3  = var.ip_addr_RE_3,
          4  = var.ip_addr_RE_4,
          5  = var.ip_addr_RE_5,
          6  = var.ip_addr_RE_6,
          7  = var.ip_addr_RE_7,
          8  = var.ip_addr_RE_8,
          9  = var.ip_addr_RE_9,
          10 = var.ip_addr_RE_10,
          11 = var.ip_addr_RE_11,
        }, i)
        priority = tostring(101 + i)
      }
    ]
  )
}
####Create a web app
resource "azurerm_linux_web_app" "linux_webapp" {
  name                          = var.web_app_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  service_plan_id               = azurerm_service_plan.asp.id
  public_network_access_enabled = var.public_access
  https_only                    = false

  site_config {
    dynamic "ip_restriction" {
      for_each = local.ip_address_list
      content {
        ip_address = ip_restriction.value.ip_add
        action     = "Allow"
        priority   = ip_restriction.value.priority
      }
    }
    ip_restriction_default_action = "Allow"
    always_on           = false
    # This has to be set to false for the F1 (free) sku
    application_stack {
      docker_image_name = var.docker_image_name
      # This is the docker image that will be used to create the web app
      }
  }
  
  tags = {
    Owner = var.owner
    Email = var.owner_email
  }
}