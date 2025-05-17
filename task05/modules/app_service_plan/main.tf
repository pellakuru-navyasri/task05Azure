resource "azurerm_app_service_plan" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  sku {
    tier     = var.sku
    size     = var.sku
    capacity = var.worker_count

  }
  tags = var.tags
}