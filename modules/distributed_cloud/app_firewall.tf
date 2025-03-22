resource "volterra_app_firewall" "example" {
  name      = "${var.namespace}-${random_pet.loadbalancer.id}-appfw"
  namespace = var.namespace
  allow_all_response_codes = true
  disable_anonymization = true
  blocking = true
  use_default_blocking_page = true
  detection_settings {
    default_bot_setting = true
    enable_suppression = true
    signature_selection_setting {
      default_attack_type_settings = true
      high_medium_low_accuracy_signatures = true
    }

    disable_staging = true
    enable_threat_campaigns = true
    default_violation_settings = true
  }
}