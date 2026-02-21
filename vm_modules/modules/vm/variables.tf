variable "resource_group_name" {}
variable "location" {}
variable "vm_name" {}
variable "vnet_name" {}
variable "subnet_name" {}
variable "admin_username" {}
variable "admin_password" {
  sensitive = true
}
variable "tags" {
  type = map(string)
}