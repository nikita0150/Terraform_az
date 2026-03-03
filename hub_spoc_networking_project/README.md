## Hub Spoke architecture 'POC'

This project demonstrates a Hub-Spoke architecture implementation where a centralized Hub manages connectivity, routing, and shared services for multiple Spoke environments.

The objective of this POC was to:

- Validate network connectivity between Hub and Spokes

- Implement centralized routing

- Enable secure communication between isolated environments

- Test scalability and modular expansion

## Components

### Hub
- Centralized routing
- Firewall
- NAT Gateway

### Spokes
- Isolated workloads
- Peered to Hub only

### Traffic Flow

1. Spoke traffic routes to Hub via UDR.
2. Hub forwards traffic through Firewall.
3. Outbound traffic exits via NAT Gateway.
4. No direct Spoke-to-Spoke communication allowed.


# Microsoft Official documentation pages 

## Networking concepts 

## 1. virtual network concepts

🔍 https://learn.microsoft.com/en-us/azure/virtual-network/concepts-and-best-practices

## 2. Firewall 

- **Firewall overview :** https://learn.microsoft.com/en-us/azure/firewall/overview
  
- **SKU selection :** https://learn.microsoft.com/en-us/azure/firewall/choose-firewall-sku

- **Firewall deployment - basic :** https://learn.microsoft.com/en-us/azure/firewall/deploy-firewall-basic-portal-policy

## 3. Terraform official documentation 

🔍 https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway

## 4. CIDR calculations 

- https://tehnoblog.org/ip-tools/cidr-to-ip-address-range/
- https://cidr.xyz/