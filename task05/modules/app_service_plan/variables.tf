variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group" {
  type = string
}
variable "sku_name" {
  type = string
}
variable "worker_count" {
  type = number
}
variable "os_type" {
  type = string
}
variable "tags" {
  type = map(string)
}