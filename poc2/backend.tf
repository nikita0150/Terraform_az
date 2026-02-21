terraform {
  backend "azurerm" {
    resource_group_name  = "panda-prod"
    storage_account_name = "storageacc235"
    container_name       = "tfstatefile"
    key                  = "poc.terraform.tfstate"
  }
}