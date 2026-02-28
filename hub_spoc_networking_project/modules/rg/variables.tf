variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the hub virtual network will be created"
}

variable "location" {
  type = string
  description = "Location of the resource group"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resource group"
  default     = {}
}