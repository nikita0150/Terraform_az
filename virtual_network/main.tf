terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {}
}

resource "azurerm_resource_group" "rg_name" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "app_network" {
  name = var.app_network_name
  resource_group_name = azurerm_resource_group.rg_name.name
  location = "${azurerm_resource_group.rg_name.location}"
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "app_subnet" {
  name = var.app_subnet_nameA
  resource_group_name = azurerm_resource_group.rg_name.name
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes = ["10.0.1.0/24"]
}