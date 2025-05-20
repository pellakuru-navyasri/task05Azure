variable "name" {
  description = "name of resource grp"
  type        = string
}
variable "location" {
  description = "region"
  type        = string
}

variable "tags" {
  description = "tags to apply"
  type        = map(string)
}