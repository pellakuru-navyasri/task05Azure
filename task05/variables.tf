variable "resource_groups" {
  description = "Map of resource groups"
  type = map(object({
    name     = string
    location = string
  }))
}

variable "app_service_plans" {
  description = "Map of app service plans"
  type = map(object({
    name         = string
    sku          = string
    os_type      = string
    worker_count = number
    rg_key       = string
  }))
}

/*variable "app_services" {
  description = "Map of app services"
  type = map(object({
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
#}*/

variable "app_services" {
  description = "Map of App Services"
  type = map(object({
    name    = string
    rg_key  = string
    asp_key = string
  }))
}

variable "allow-ip" {
  description = "Verification agent IP Address"
  type        = string
}

variable "allow_ip_rule" {
  description = "Name of IP Allow rule"
  type        = string
}

variable "allow_tag_rule" {
  description = "Name of service tag Allow rule"
  type        = string
}

variable "traf_name" {
  description = "Name of the Traffic Manager profile"
  type        = string
}

variable "traf_routing_method" {
  description = "Routing method for the Traffic Manager"
  type        = string
}

variable "tr_rg" {
  description = "Resource Group for Traffic Manager"
  type        = string
}

variable "tr_app1" {
  description = "App 1 for Traffic Manager Endpoint"
  type        = string
}

variable "tr_app2" {
  description = "App 2 for Traffic Manager Endpoint"
  type        = string
}

variable "pr_app1" {
  description = "Priority of App 1"
  type        = string
}

variable "pr_app2" {
  description = "Priority of App 2"
  type        = string
}
variable "tags" {
  type        = map(string)
  description = "tags to apply on resources"
}
