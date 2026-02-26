variable "hub_vnet_name" {
    type        = string
    description = "Name of the hub virtual network"
    default     = "hub-vnet"
}

variable "address_space" {
    type        = list(string)
    description = "Address space for the hub virtual network"
}

variable "location" {
    type        = string
    description = "Azure region for the hub virtual network"
}

variable "resource_group_name" {
    type        = string
    description = "Name of the resource group where the hub virtual network will be created"
}

variable "tags" {
    type        = map(string)
    description = "Tags to be applied to the hub virtual network"
    default     = {}
}

variable "subnet_prefixes" {
    type        = map(string)
    description = "Map of subnet names to their respective CIDR prefixes"
    default     = {}
}

variable "create_firewall_subnet" {
    type        = bool
    description = "Flag to determine whether to create a firewall subnet"
    default     = false
}

variable "firewall_subnet_cidr" {
    type        = string
    description = "CIDR prefix for the firewall subnet"
    default     = "10.0.0.0/26"
}

variable "create_bastion_subnet" {
    type        = bool
    description = "Flag to determine whether to create a bastion subnet"
    default     = true
}

variable "bastion_subnet_cidr" {
    type        = string
    description = "CIDR prefix for the bastion subnet"
    default     = "10.0.0.64/26"
}

variable "create_gateway_subnet" {
  type = bool
  description = "Flag to determine whether to create a gateway subnet"
  default = false
}

variable "gateway_subnet_cidr" {
  type = string
  description = "CIDR prefix for the gateway subnet"
  default = "10.0.255.0/27"
}