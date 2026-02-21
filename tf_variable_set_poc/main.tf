terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  cloud {
    organization = "panda-terraform"

    workspaces {
      name = "azuretfpoc"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

output "rg_name" {
  value = azurerm_resource_group.example.name
}

/*
Terraform Cloud Organization
│
├── Variable Set: azure-auth
│      ├── ARM_CLIENT_ID
│      ├── ARM_CLIENT_SECRET
│      ├── ARM_SUBSCRIPTION_ID
│      └── ARM_TENANT_ID
│
├── Workspace: azure-poc
│      ├── resource_group_name (Terraform Variable)
│      └── location (Terraform Variable)
│
├── Workspace: dev
├── Workspace: prod

*/