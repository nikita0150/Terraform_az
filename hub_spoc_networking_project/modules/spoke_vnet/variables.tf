variable "spoke_vnet_name" {
  type        = string
  description = "Name of the spoke virtual network"
}

variable "location" {
  type = string
  description = "Location name"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the spoke virtual network will be created" 
}

variable "spoke_vnet_address_space" {
  type        = list(string)
  description = "Address space for the spoke virtual network"   
}

variable "subnet_prefixes" {
  type        = map(string)
  description = "Map of subnet names to their corresponding CIDR prefixes for the spoke virtual network"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the spoke virtual network and its subnets"
  default     = {}
}