resource "azurerm_route_table" "rt" {
  name                = "hub-route-table"
  location            = var.location
  resource_group_name = var.resource_group_name
  #disable_bgp_route_propagation = true
  tags = var.tags
}

#Default route to firewall private IP for internet egress traffic
resource "azurerm_route" "default_to_firewall" {
  name                = "default-to-firewall"
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.rt.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "VirtualAppliance"
  next_hop_in_ip_address = var.firewall_private_ip
}

resource "azurerm_subnet_route_table_association" "subnet_association" {
  for_each = var.subnet_ids
  subnet_id      = each.value
  route_table_id = azurerm_route_table.rt.id
}