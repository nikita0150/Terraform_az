output "vnet_id" {
  value = azure_virtual_network.spoke_vnet.id
}

output "vnet_name" {
  value = azure_virtual_network.spoke_vnet.name
}

output "subnet_ids" {
  value = { for k, s in azure_subnet.spoke_subnet : k => s.id }
  
}