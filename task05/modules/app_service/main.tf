/*resource "azurerm_windows_web_app" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id

  site_config {
    always_on = true

    dynamic "ip_restriction" {
      for_each = var.allowed_ip_address
      content {
        name       = ip_restriction.value.name
        ip_address = ip_restriction.value.ip_address
        action     = "Allow"
        priority   = ip_restriction.value.priority
      }
    }

    ip_restriction {
      name        = var.tm_rule.name
      service_tag = "AzureTrafficManager"
      action      = "Allow"
      priority    = var.tm_rule.priority
    }
    ip_restriction {
      name        = "DenyAllOthers"
      ip_address  = "0.0.0.0/0"  # Matches all IPs not explicitly allowed
      action      = "Deny"
      priority    = 1000         # Priority must be higher than any Allow rule
    }
  }

  tags = var.tags
}*/

resource "azurerm_windows_web_app" "APP" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = var.app_service_plan_id
  tags                = var.tags

  site_config {
    always_on                     = true
    ip_restriction_default_action = "Deny"

    dynamic "ip_restriction" {
      for_each = [
        {
          name       = var.allow_ip_rule
          ip_address = var.allow-ip
          priority   = 100
          action     = "Allow"
        },
        {
          name        = var.allow_tag_rule
          service_tag = "AzureTrafficManager"
          priority    = 200
          action      = "Allow"
        }
      ]

      content {
        name        = ip_restriction.value.name
        priority    = ip_restriction.value.priority
        action      = ip_restriction.value.action
        ip_address  = lookup(ip_restriction.value, "ip_address", null)
        service_tag = lookup(ip_restriction.value, "service_tag", null)
      }
    }
  }

  ##ip_restriction_default_action = "Deny"

}