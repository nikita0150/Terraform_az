variable "spoke_vnet_name" {
    type        = string
    description = "Name of the spoke virtual network"
    default     = "spoke-vnet"
}

variable "spoke_vnet_address_space" {
    type        = list(string)
    description = "Address space for the spoke virtual network"
}

variable "resource_group_name" {
    type        = string
    description = "Name of the resource group where the spoke virtual network will be created"
}
variable "location" {
    type        = string
    description = "Azure region for the spoke virtual network"
}

variable "tags" {
    type        = map(string)
    description = "Tags to be applied to the spoke virtual network"
    default     = {}
}

variable "spoke_subnet_prefixes" {
    type        = map(string)
    description = "Map of subnet names to their respective CIDR prefixes for the spoke virtual network"
    default     = {}
}

variable "create_nsg" {
    type        = bool
    description = "Flag to determine whether to create NSGs for the spoke virtual network"
    default     = false
  
}