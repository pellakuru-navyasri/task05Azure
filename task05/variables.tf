variable "resource_groups" {
  description = "Map of resource groups"
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}

variable "app_service_plans" {
  description = "Map of app service plans"
  type = map(object({
    name         = string
    location     = string
    sku_name     = string
    os_type      = string
    worker_count = number
    tags         = map(string)
    rg_key       = string
  }))
}

variable "app_services" {
  description = "Map of app services"
  type = map(object({
    name                = string
    name                = string
    resource_group_name = string
    location            = string
    app_service_plan_id = string
    allowed_ip_addresses = map(object({
      name       = string
      ip_address = string
      priority   = number
    }))
    tm_rule = object({
      name     = string
      priority = number
    })
    tags = map(string)
  }))
}

variable "traffic_manager" {
  description = "Traffic Manager configuration"
  type = object({
    name                = string
    resource_group_name = string
    routing_method      = string
    tags                = map(string)
    endpoints = map(object({
      target_resource_id = string
      location           = string
      priority           = number
    }))
  })
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
#variable "allowed_ip_address" {
#  name       = string

#  ip_address = string
# priority   = number
#}))
#}