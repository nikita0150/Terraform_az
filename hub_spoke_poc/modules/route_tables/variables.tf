variable "name" {
    type        = string
    description = "Name of the route table"
    default     = "my-route-table"
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

variable "subnet_ids" {
    type        = map(string)
    description = "List of subnet IDs to be associated with the route table"
    default     = {}
}

variable  "firewall_private_ip" {
    type        = string
    description = "Private IP address of the firewall"
}

variable "enable_forced_tunneling" {
    type        = bool
    description = "Flag to determine whether to enable forced tunneling on the firewall"
    default     = false
}