resource "azure_virtual_network" "hub_vnet" {
    name                = var.hub_vnet_name
    address_space       = var.address_space
    location            = var.location
    resource_group_name = var.resource_group_name
    tags               = var.tags
}

resource "azure_subnet" "generic_subnet" {
    for_each = var.subnet_prefixes
    name                 = each.key
    resource_group_name  = var.resource_group_name
    virtual_network_name = azure_virtual_network.hub_vnet.name
    address_prefixes     = [each.value]
}

resource "azure_subnet" "firewall_subnet" {
    count               = var.create_firewall_subnet ? 1 : 0
    name                 = "firewallSubnet"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azure_virtual_network.hub_vnet.name
    address_prefixes     = [var.firewall_subnet_cidr]
}

resource "azure_subnet" "bastion_subnet" {
    count               = var.create_bastion_subnet ? 1 : 0
    name                 = "bastionSubnet"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azure_virtual_network.hub_vnet.name
    address_prefixes     = [var.bastion_subnet_cidr]
}

resource "azure_subnet" "gateway_subnet" {
    count               = var.create_gateway_subnet ? 1 : 0
    name                 = "GatewaySubnet"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azure_virtual_network.hub_vnet.name
    address_prefixes     = [var.gateway_subnet_cidr]
}
