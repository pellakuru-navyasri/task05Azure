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

  name           = each.value.name
  location       = module.resource_groups[each.value.rg_key].location
  resource_group = module.resource_groups[each.value.rg_key].name
  sku_name       = each.value.sku_name
  os_type        = each.value.os_type
  worker_count   = each.value.worker_count
  tags           = each.value.tags
  depends_on     = [module.resource_groups]
}

# Create App Services
module "app_services" {
  source   = "./modules/app_service"
  for_each = var.app_services

  name                = each.value.name
  resource_group_name = each.key == "app1" ? module.resource_groups["rg1"].name : module.resource_groups["rg2"].name
  location            = each.value.location
  service_plan_id     = each.key == "app1" ? module.app_service_plans["asp1"].id : module.app_service_plans["asp2"].id
  allowed_ip_address  = each.value.allowed_ip_addresses
  tm_rule             = each.value.tm_rule
  tags                = each.value.tags

  depends_on = [module.app_service_plans, module.resource_groups]
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
  depends_on = [module.app_services]
}
