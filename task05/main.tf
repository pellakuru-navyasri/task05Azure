# Create resource groups
/*module "resource_groups" {
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
*/
module "rg" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
  tags     = var.tags
}

module "ASP" {
  source         = "./modules/app_service_plan"
  for_each       = var.app_service_plans
  name           = each.value.name
  sku            = each.value.sku
  worker_count   = each.value.worker_count
  resource_group = var.resource_groups[each.value.rg_key].name
  location       = var.resource_groups[each.value.rg_key].location
  os_type        = each.value.os_type
  tags           = var.tags

  depends_on = [module.rg]
}

module "APP" {
  source   = "./modules/app_service"
  for_each = var.app_services

  name                = each.value.name
  location            = var.resource_groups[each.value.rg_key].location
  resource_group      = var.resource_groups[each.value.rg_key].name
  app_service_plan_id = module.ASP[each.value.asp_key].ASP_id
  allow-ip            = var.allow-ip
  allow_ip_rule       = var.allow_ip_rule
  allow_tag_rule      = var.allow_tag_rule
  tags                = var.tags

  depends_on = [module.ASP]
}

module "traffic_manager" {
  source = "./modules/traffic_manager"
  name   = var.traf_name

  resource_group = var.resource_groups[var.tr_rg].name

  routing_method = var.traf_routing_method

  endpoints = {
    app1 = {
      name        = var.app_services[var.tr_app1].name
      target      = module.APP[var.tr_app1].app_hostname
      resource_id = module.APP[var.tr_app1].app_id
      pr          = var.pr_app1
    },
    app2 = {
      name        = var.app_services[var.tr_app2].name
      target      = module.APP[var.tr_app2].app_hostname
      resource_id = module.APP[var.tr_app2].app_id
      pr          = var.pr_app2
    }
  }

  tags = var.tags

  depends_on = [module.APP]
}