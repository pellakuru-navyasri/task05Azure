# Create resource groups
module "resource_groups" {
  source = "./modules/resource_group"

  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
  tags     = each.value.tags
}

# Create App Service Plans
module "app_service_plans" {
  source = "./modules/app_service_plan"

  for_each = var.app_service_plans

  name           = each.value.resource_group_name
  location       = var.resource_groups[each.value.rg1].location
  resource_group = module.resource_groups[each.value.rg1].name
  sku            = each.value.sku
  worker_count   = each.value.worker_count
  tags           = each.value.tags
}

# Create App Services
module "app_services" {
  source = "./modules/app_service"

  for_each = var.app_services

  name                = each.key == "app1" ? "cmaz-vwx4iuxh-mod5-app-01" : "cmaz-vwx4iuxh-mod5-app-02"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  service_plan_id     = module.app_service_plans[each.key == "app1" ? "asp1" : "asp2"].id
  allowed_ip_address  = each.value.allowed_ip_addresses
  tm_rule             = each.value.tm_rule
  tags                = each.value.tags
}

# Create Traffic Manager Profile with endpoints
module "traffic_manager" {
  source = "./modules/traffic_manager"

  name                = var.traffic_manager.name
  resource_group_name = var.traffic_manager.resource_group_name
  routing_method      = var.traffic_manager.routing_method
  tags                = var.traffic_manager.tags

  endpoints = {
    for key, ep in var.traffic_manager.endpoints : key => {
      target_resource_id = module.app_services[key].id
      location           = ep.location
      priority           = ep.priority
    }
  }
}
