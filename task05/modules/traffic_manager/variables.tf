/*variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "routing_method" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "endpoints" {
  type = map(object({
    target_resource_id = string
    location           = string
    priority           = number
  }))
}*/
variable "name" {
  type        = string
  description = "TM profile name"
}

variable "resource_group" {
  type        = string
  description = "RG name"
}

variable "routing_method" {
  type        = string
  description = "Routing Method"
}

variable "endpoints" {
  description = "Map of endpoints"
  type = map(object({
    name        = string
    target      = string
    resource_id = string
    pr          = number
  }))
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
}