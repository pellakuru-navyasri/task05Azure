resource "azurerm_service_plan" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = var.os_type
  tags                = var.tags
  sku_name            = var.sku_name
}