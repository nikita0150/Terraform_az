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