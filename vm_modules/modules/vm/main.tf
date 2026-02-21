#VNet is required before creating the VM, so we will create the VNet and Subnet in this file. 
#We will also create a public IP address and a network interface for the VM. Finally, we will create the VM itself.
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name #links this subnet to the resource group above
  virtual_network_name = azurerm_virtual_network.vnet.name #links this subnet to the VNet above
  address_prefixes     = ["10.0.1.0/24"] #specifies the address range for the subnet. This is a subset of the VNet's address space.
}

#create a public IP address for the VM
resource "azurerm_public_ip" "pip" {
  name                = "${var.vm_name}-pip" 
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static" #ip won't change when the VM is restarted
  sku = "Standard"               #required for static public IPs. Standard SKU provides better performance and availability than Basic SKU.
  tags                = var.tags
}

#create a network interface for the VM and associate it with the subnet and public IP address
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"   #assigns a specific private IP address to the VM.
     #This is optional, but it can be useful for certain scenarios where you want to ensure that the VM always has the same private IP address.
    public_ip_address_id          = azurerm_public_ip.pip.id #links the network interface to the public IP address created above, allowing the VM to be accessible from the internet.
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [ #associates the VM with the network interface created above, which in turn is associated with the subnet and public IP address.
    azurerm_network_interface.nic.id
  ]

  os_disk {   #specifies the configuration for the OS disk of the VM. The OS disk is where the operating system is installed and runs from.
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference { #specifies the image to use for the VM. In this case, we're using a Windows Server 2019 Datacenter image from the Azure Marketplace.
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = var.tags
}

/*
how everythinc connects together:
VNet (10.0.0.0/16)
 └── Subnet (10.0.1.0/24)
       └── NIC
             ├─ Private IP: 10.0.1.x
             └─ Public IP: linked for internet
                   └─ Windows VM
*/