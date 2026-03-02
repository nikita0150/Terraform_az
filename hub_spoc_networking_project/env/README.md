/* 
## Hub vnet cidr [10.0.0.0/16] - /16 gives 65,536 IP addresses

The Hub VNet is the central control plane of the landing zone.

It will host:

Azure Firewall

VPN Gateway / ExpressRoute

Bastion

Shared services (DNS, AD, monitoring)

Future infra components

So we choose a large address space to avoid future re-IPing.

------------------------------------------------------------

## Spoke = 10.1.0.0/16

Future Spoke = 10.2.0.0/16, 10.3.0.0/16 
We can scale properly in the future 

-------------------------------------------------------------

## Azure Firewall Subnet - Minimum = /26 - 64 IPs
Azure Firewall scales internally.

It requires enough IPs for:

Backend instances/Scaling units/Internal load balancers

This is the minimum supported size for production.

Using /24 works but wastes IP space.

--------------------------------------------------------------

##  Gateway Subnet - Minimum /27 - 32 IPs

VPN Gateway / ExpressRoute do not need large IP pools.

32 ips are More than enough for:

Active-Active VPN

ER redundancy

Future scale

Microsoft recommends /27 or larger.

--------------------------------------------------------------
## AzureBastionSubnet = /27

Bastion requires:

Minimum: /26 (for Standard SKU)

If using Basic SKU → /27 may work
If production → better to use /26

Reason:
Bastion scales similarly to Firewall (internally managed instances).