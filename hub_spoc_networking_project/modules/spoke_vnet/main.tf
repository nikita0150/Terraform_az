resource "azurerm_virtual_network" "spoke_vnet" {
  name                = var.spoke_vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.spoke_vnet_address_space
  #dns_servers         = var.spoke_vnet_dns_servers
}

resource "azurerm_subnet" "spoke_subnet" {
  for_each = var.subnet_prefixes
  name                 = each.key 
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = [each.value]
}

#NSG for spoke subnets
resource "azurerm_network_security_group" "spoke_nsg" {
  for_each = var.subnet_prefixes
  name                = "${var.spoke_vnet_name}-${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

#attach NSG to spoke subnets
resource "azurerm_subnet_network_security_group_association" "spoke_assoc" {
  for_each = var.subnet_prefixes

  subnet_id                 = azurerm_subnet.spoke_subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.spoke_nsg[each.key].id
}

# Route Table for spoke subnets

resource "azurerm_route_table" "spoke_rt" {
  name                = "${var.spoke_vnet_name}-rt"
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name           = "default-route"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }

  tags = var.tags
}

resource "azurerm_subnet_route_table_association" "spoke_assoc" {
  for_each = azurerm_subnet.spoke_subnets

  subnet_id      = each.value.id
  route_table_id = azurerm_route_table.spoke_rt.id
}