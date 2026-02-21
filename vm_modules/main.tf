resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.common_tags
}

module "vm" {
  source = "./modules/vm"

  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  vm_name             = local.vm_name
  vnet_name           = local.vnet_name
  subnet_name         = local.subnet_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = local.common_tags
}