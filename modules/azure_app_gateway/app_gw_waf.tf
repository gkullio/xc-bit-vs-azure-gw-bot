locals {
  bot_rules = {
    UnknownBots = [
      { id = "300100", enabled = true, action = "Block" },
      { id = "300200", enabled = true, action = "Block" },
      { id = "300300", enabled = true, action = "Block" },
      { id = "300400", enabled = true, action = "Block" },
      { id = "300500", enabled = true, action = "Block" },
      { id = "300600", enabled = true, action = "Block" },
      { id = "300700", enabled = true, action = "Block" },
    ]
    GoodBots = [
      { id = "200100", enabled = true, action = "Block" },
      { id = "200200", enabled = true, action = "Block" },
      { id = "200300", enabled = true, action = "Block" },
      { id = "200400", enabled = true, action = "Block" },
      { id = "200500", enabled = true, action = "Block" },
      { id = "200600", enabled = true, action = "Block" },
      { id = "200700", enabled = true, action = "Block" },
    ]
  }
}

resource "azurerm_web_application_firewall_policy" "app_gw_waf" {
  name                = var.waf_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location

  policy_settings {
    enabled                       = true
    mode                          = var.waf_policy_mode
    request_body_check            = true
    file_upload_limit_in_mb       = 100
    file_upload_enforcement       = true
    max_request_body_size_in_kb   = 128
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
    managed_rule_set {
      type    = "Microsoft_BotManagerRuleSet"
      version = "1.1"

      dynamic "rule_group_override" {
        for_each = local.bot_rules
        content {
          rule_group_name = rule_group_override.key
          dynamic "rule" {
            for_each = rule_group_override.value
            content {
              id      = rule.value.id
              enabled = rule.value.enabled
              action  = rule.value.action
            }
          }
        }
      }
    }
  }
}