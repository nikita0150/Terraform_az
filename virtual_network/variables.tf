variable "subscription_id" {
  description = "The subscription ID for the Azure account."
  type        = string
}

variable "client_id" {
  description = "The client ID for the Azure service principal."
  type        = string
}

variable "client_secret" {
  description = "The client secret for the Azure service principal."
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The tenant ID for the Azure account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
}

variable "location" {
  description = "The location where the resource group will be created."
  type        = string
}

variable "app_network_name" {
  description = "The name of the virtual network to create."
  type        = string
  
}

variable "app_subnet_nameA" {
  description = "The name of the subnet to create within the virtual network."
  type        = string
}