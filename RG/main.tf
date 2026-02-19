terraform {
#specify the required providers and their versions  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

provider "azurerm" {
#specify the credentials for the Azure provider
  subscription_id = "nmm-0000-0000-0000-000000000000"
  client_id = "nmm-0000-0000-0000-000000000000"
  client_secret = "nmm-0000-0000-0000-000000000000"
  tenant_id = "nmm-0000-0000-0000-000000000000"
  features {} 
}

resource "azurerm_resource_group" "Panda_dev" {  #this line is entirely to identify resources within this file
#specify the name and location of the resource group
  name     = "Panda_dev"     #this are the arguments which are required to create the resource group in azure portal
  location = "eastus"
}

resource "azurerm_resource_group" "Panda_prod" {  #this line is entirely to identify resources within this file
#specify the name and location of the resource group
  name     = "Panda_prod"     #this are the arguments which are required to create the resource group in azure portal
  location = "eastus"
}