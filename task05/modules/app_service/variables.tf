variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "service_plan_id" {
  type = string
}

variable "allowed_ip_address" {
  description = "List of allowed IP addresses with metadata"
  type = map(object({
    name       = string
    ip_address = string
    priority   = number
  }))
}


variable "tm_rule" {
  type = object({
    name     = string
    priority = number
  })
}

variable "tags" {
  type = map(string)
}