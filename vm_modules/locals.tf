locals {
  location            = "East US"
  resource_group_name = "rg-${var.project}-${var.environment}"
  vm_name             = "vm-${var.project}-${var.environment}"
  vnet_name           = "vnet-${var.project}-${var.environment}"
  subnet_name         = "subnet-${var.project}-${var.environment}"

  common_tags = {
    project     = var.project
    environment = var.environment
  }
}