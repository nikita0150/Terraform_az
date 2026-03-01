output "hub_vnet_id" {
  value = azurerm_virtual_network.hub_vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.hub_vnet.name
}

output "generic_subnet_ids" {
  value = {
    for k, v in azurerm_subnet.generic_subnets :
    k => v.id
  }
}

output "firewall_subnet_id" {
  value       = try(azurerm_subnet.firewall_subnet[0].id, null)
}

output "bastion_subnet_id" {
  value       = try(azurerm_subnet.bastion_subnet[0].id, null)
}

output "gateway_subnet_id" {
  value       = try(azurerm_subnet.gateway_subnet[0].id, null)
}