provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "poc" {
  name     = var.resource_group_name
  location = var.location
}

output "rg_name" {
  value = azurerm_resource_group.poc.name
}


