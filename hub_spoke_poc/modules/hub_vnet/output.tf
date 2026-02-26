output "hub_vnet_name" {
    value = azure_virtual_network.hub_vnet.name
}
output "hub_vnet_id" {
    value = azure_virtual_network.hub_vnet.id
}

output "generic_subnet_ids" {
    value = { for k, s in azure_subnet.generic_subnet : k => s.id }
}

output "firewall_subnet_id" {
    value = try(azure_subnet.firewall_subnet[0].id, null)
    description = "Null if not created"
}

output "bastion_subnet_id" {
  value = try(azure_subnet.bastion_subnet[0].id, null)
  description = "Null if not created"
}

output "gateway_subnet_id" {
  value = try(azure_subnet.gateway_subnet[0].id, null)
  description = "Null if not created"
}