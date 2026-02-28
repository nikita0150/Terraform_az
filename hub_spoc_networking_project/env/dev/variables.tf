variable "org_name" {
  description = "Organization short name"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "region_short" {
  description = "Short region code (eus, wus, etc)"
  type        = string
}

variable "location" {
  type = string
}

variable "hub_address_space" {
  type = list(string)
}

variable "hub_subnet_prefixes" {
  type = map(string)
}

variable "firewall_subnet_cidr" {
  type = string
}

variable "bastion_subnet_cidr" {
  type = string
}

variable "gateway_subnet_cidr" {
  type = string
}

variable "project_name" {
  type = string
}

variable "owner" {
  type = string
}

variable "tags" {
  type = map(string)
}

#=========================

variable "spoke_vnet_address_space" {
  type        = list(string)
}

variable "spoke_subnet_prefixes" {
  type        = map(string)
}