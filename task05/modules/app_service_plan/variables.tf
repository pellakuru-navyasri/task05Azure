variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group" {
  type = string
}
variable "sku" {
  type = string
}
variable "worker_count" {
  type = number
}
variable "tags" {
  type = map(string)
}