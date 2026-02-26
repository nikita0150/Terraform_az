variable "hub_vnet_name" {
    type        = string
    description = "Name of the hub virtual network"
}

variable "spoke_vnet_name" {
    type        = string
    description = "Name of the spoke virtual network"
    default     = "spoke-vnet"
}

variable "hub_resource_group_name" {
    type        = string
    description = "Name of the resource group where the hub virtual network is located"  
}

variable "spoke_resource_group_name" {
    type        = string
    description = "Name of the resource group where the spoke virtual network is located"  
}

variable "hub_vnet_id" {
  type = string
  description = "ID of the hub virtual network"
}

variable "spoke_vnet_id" {
    type        = string
    description = "ID of the spoke virtual network"
}

variable "allow_forwarded_traffic" {
    type        = bool
    description = "Flag to allow forwarded traffic in the peering"
    default     = false
}

variable "allow_gateway_transit" {
    type        = bool
    description = "Flag to allow gateway transit in the peering"
    default     = false
}
