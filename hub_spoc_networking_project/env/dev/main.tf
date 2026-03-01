#### Hub setup #####

locals {
  hub_rg_name   = "${var.org_name}-${var.environment}-${var.region_short}-rg-network-01"
  hub_vnet_name = "${var.org_name}-${var.environment}-${var.region_short}-vnet-hub-01"
  spoke_rg_name = "${var.org_name}-${var.environment}-${var.region_short}-rg-spoke-01"
  spoke_vnet_name = "${var.org_name}-${var.environment}-${var.region_short}-vnet-spoke-01"
}

locals {
  default_tags = {
    organization = var.org_name
    environment  = var.environment
    project      = var.project_name
    owner        = var.owner
    managedby    = "terraform"
  }

  final_tags = merge(local.default_tags, var.tags)
}

module "hub_vnet" {
  source              = "../../modules/hub_vnet"
  location            = var.location
  resource_group_name = local.hub_rg_name
  hub_vnet_name       = local.hub_vnet_name
  address_space       = var.hub_address_space

  subnet_prefixes = var.hub_subnet_prefixes
  
  create_firewall_subnet = true
  firewall_subnet_cidr   = var.firewall_subnet_cidr

  create_bastion_subnet  = true
  bastion_subnet_cidr    = var.bastion_subnet_cidr

  create_gateway_subnet  = true
  gateway_subnet_cidr    = var.gateway_subnet_cidr

  tags = local.final_tags
}
##spoke setup

module "spoke_vnet" {
  source             = "../../modules/spoke_vnet"
  location            = var.location
  resource_group_name = local.spoke_rg_name
  spoke_vnet_name     = local.spoke_vnet_name
  spoke_vnet_address_space = var.spoke_vnet_address_space

  subnet_prefixes = var.spoke_subnet_prefixes

  tags = local.final_tags
}

## peering hub to spoke ##
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "hub-to-spoke"
  resource_group_name       = module.hub_vnet.resource_group_name
  virtual_network_name      = module.hub_vnet.hub_vnet_name
  remote_virtual_network_id = module.spoke_vnet.spoke_vnet_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

# peering spoke to hub ##
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "spoke-to-hub"
  resource_group_name       = module.spoke_vnet.resource_group_name
  virtual_network_name      = module.spoke_vnet.spoke_vnet_name
  remote_virtual_network_id = module.hub_vnet.hub_vnet_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}