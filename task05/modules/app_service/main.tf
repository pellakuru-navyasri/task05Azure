resource "azurerm_windows_web_app" "this" {
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
  }

  tags = var.tags
}