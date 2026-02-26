resource "azure_virtual_network" "spoke_vnet" {
  name                = var.spoke_vnet_name
  address_space       = var.spoke_vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azure_subnet" "spoke_subnet" {
  for_each = var.spoke_subnet_prefixes
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azure_virtual_network.spoke_vnet.name
  address_prefixes     = [each.value]
}

# Optional NSG per subnet
resource "azure_network_security_group" "spoke_nsg" {
  count              = var.create_nsg ? 1 : 0
  name              = "${var.spoke_vnet_name}-nsg"
  location             = var.location
  resource_group_name  = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "AllowVnetInBound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

    security_rule {
        name                       = "AllowInternetOutBound"
        priority                   = 200
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "Internet"
    }

    security_rule {
        name                       = "AllowLoadbalancerInBound"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "denyallinbound"
        priority                   = 4096
        direction                  = "Inbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azure_subnet_network_security_group_association" "spoke_subnet_nsg_assoc" {
  for_each = var.create_nsg ? azure_subnet.spoke_subnet : {}
  subnet_id                 = each.value.id
  network_security_group_id = azure_network_security_group.spoke_nsg[0].id
}