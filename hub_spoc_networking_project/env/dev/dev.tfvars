org_name     = "vw"
environment  = "dev"
region_short = "eus"
project_name = "networking"
owner        = "panda"

location = "eastus"

hub_address_space = ["10.0.0.0/16"]

hub_subnet_prefixes = {
  SharedServicesSubnet = "10.0.3.0/24"
  ManagementSubnet     = "10.0.4.0/24"
}

firewall_subnet_cidr = "10.0.0.0/24"
bastion_subnet_cidr  = "10.0.1.0/24"
gateway_subnet_cidr  = "10.0.2.0/24"

tags = {
  environment = "dev"
}

#================
spoke_vnet_address_space = ["10.1.0.0/16"]

spoke_subnet_prefixes = {
  web = "10.1.1.0/24"
  app = "10.1.2.0/24"
}