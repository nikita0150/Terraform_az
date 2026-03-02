# Virtual Network
resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

# Generic Subnets
resource "azurerm_subnet" "generic_subnets" {
  for_each = var.subnet_prefixes 
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [each.value]
}

resource "azurerm_network_security_group" "generic_nsg" {
  for_each = var.subnet_prefixes
  name                = "${var.hub_vnet_name}-${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "generic_assoc" {
  for_each = var.subnet_prefixes

  subnet_id                 = azurerm_subnet.generic_subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.generic_nsg[each.key].id
}

# Azure Firewall Subnet (keep the name as AzureFirewallSubnet - compulsory)
resource "azurerm_subnet" "firewall_subnet" {
  count = var.create_firewall_subnet ? 1 : 0
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.firewall_subnet_cidr]
}

resource "azurerm_public_ip" "firewall_pip" {
  count = var.create_firewall_subnet ? 1 : 0

  name                = "${var.hub_vnet_name}-azfw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall_policy" "hub_fw_policy" {
  count               = var.create_firewall_subnet ? 1 : 0
  name                = "${var.hub_vnet_name}-fw-policy"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.firewall_sku_tier

  tags = var.tags
}

resource "azurerm_firewall_policy_rule_collection_group" "default_rules" {
  count              = var.create_firewall_subnet ? 1 : 0
  name               = "default-rule-group"
  firewall_policy_id = azurerm_firewall_policy.hub_fw_policy[0].id
  priority           = 100

  network_rule_collection {
    name     = "allow-internet"
    priority = 100
    action   = "Allow"

    rule {
      name                  = "allow-http-https"
      protocols             = ["TCP"]
      source_addresses      = var.spoke_vnet_address_space
      destination_addresses = ["*"]
      destination_ports     = ["80", "443"]
    }
  }
    application_rule_collection {
    name     = "allow-web"
    priority = 200
    action   = "Allow"

    rule {
      name             = "allow-ms-updates"
      source_addresses = var.spoke_vnet_address_space
      #target_fqdn_tags = ["WindowsUpdate"]

      protocols {
        port = 443
        type = "Https"
      }
    }
  }
}

resource "azurerm_firewall" "hub_fw" {
  count               = var.create_firewall_subnet ? 1 : 0
  name                = "${var.hub_vnet_name}-azfw"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = var.firewall_sku_tier

  firewall_policy_id = azurerm_firewall_policy.hub_fw_policy[0].id

  ip_configuration {
    name                 = "fw-ipconfig"
    subnet_id            = azurerm_subnet.firewall_subnet[0].id
    public_ip_address_id = azurerm_public_ip.firewall_pip[0].id
  }

  tags = var.tags
}

# Azure Bastion Subnet (Mandatory Name)
resource "azurerm_subnet" "bastion_subnet" {
  count = var.create_bastion_subnet ? 1 : 0
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.bastion_subnet_cidr]
}

# Gateway Subnet (Mandatory Name)
resource "azurerm_subnet" "gateway_subnet" {
  count = var.create_gateway_subnet ? 1 : 0
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.gateway_subnet_cidr]
}