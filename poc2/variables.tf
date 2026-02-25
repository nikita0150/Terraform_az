variable "resource_group_name" {
  type        = string
  description = "Name of resource group"
  default = "my-rg"
}

variable "location" {
  type        = string
  description = "Azure region"
  default = "eastus"
}
