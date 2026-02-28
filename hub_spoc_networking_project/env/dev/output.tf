# Hub VNet Outputs

output "hub_vnet_id" {
  description = "ID of the Hub Virtual Network"
  value       = module.hub_vnet.vnet_id
}

output "hub_vnet_name" {
  description = "Name of the Hub Virtual Network"
  value       = module.hub_vnet.vnet_name
}

output "hub_generic_subnet_ids" {
  description = "Map of generic subnet IDs"
  value       = module.hub_vnet.generic_subnet_ids
}

output "hub_firewall_subnet_id" {
  description = "Firewall subnet ID"
  value       = module.hub_vnet.firewall_subnet_id
}

output "hub_bastion_subnet_id" {
  description = "Bastion subnet ID"
  value       = module.hub_vnet.bastion_subnet_id
}

output "hub_gateway_subnet_id" {
  description = "Gateway subnet ID"
  value       = module.hub_vnet.gateway_subnet_id
}