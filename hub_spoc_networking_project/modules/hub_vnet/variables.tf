variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "hub_vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}

# Generic subnets (shared, management, etc.)
variable "subnet_prefixes" {
  description = "Map of subnet name to CIDR"
  type        = map(string)
  default     = {}
}

# Optional dedicated subnets
variable "create_firewall_subnet" {
  type    = bool
  default = false
}

variable "firewall_subnet_cidr" {
  type    = string
  default = null
}

variable "create_bastion_subnet" {
  type    = bool
  default = false
}

variable "bastion_subnet_cidr" {
  type    = string
  default = null
}

variable "create_gateway_subnet" {
  type    = bool
  default = false
}

variable "gateway_subnet_cidr" {
  type    = string
  default = null
}