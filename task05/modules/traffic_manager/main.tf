resource "azurerm_traffic_manager_profile" "this" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  traffic_routing_method = var.routing_method
  dns_config {
    relative_name = var.name
    ttl           = 30
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 10
    tolerated_number_of_failures = 3
  }

  tags = var.tags
}

resource "azurerm_traffic_manager_azure_endpoint" "endpoints" {
  for_each   = var.endpoints
  name       = each.key
  profile_id = azurerm_traffic_manager_profile.this.id
  #resource_group_name     = var.resource_group_name
  target_resource_id = each.value.target_resource_id
  priority           = each.value.priority
}