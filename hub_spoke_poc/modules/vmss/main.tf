############################################
# Public IP
############################################

resource "azurerm_public_ip" "lb_public_ip" {
  count               = var.create_lb ? 1 : 0
  name                = "${var.name}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = var.lb_sku
  tags                = var.tags
}

############################################
# Load Balancer
############################################

resource "azurerm_lb" "lb" {
  count               = var.create_lb ? 1 : 0
  name                = "${var.name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = "public"
    public_ip_address_id = azurerm_public_ip.lb_public_ip[0].id
  }

  tags = var.tags
}

############################################
# Backend Pool
############################################

resource "azurerm_lb_backend_address_pool" "bepool" {
  count           = var.create_lb ? 1 : 0
  name            = "${var.name}-bepool"
  loadbalancer_id = azurerm_lb.lb[0].id
}

############################################
# Health Probe
############################################

resource "azurerm_lb_probe" "http" {
  count           = var.create_lb ? 1 : 0
  name            = "${var.name}-http-probe"
  loadbalancer_id = azurerm_lb.lb[0].id
  protocol        = "Tcp"
  port            = 80
}

############################################
# LB Rule
############################################

resource "azurerm_lb_rule" "http" {
  count                          = var.create_lb ? 1 : 0
  name                           = "http"
  loadbalancer_id                = azurerm_lb.lb[0].id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "public"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bepool[0].id]
  probe_id                       = azurerm_lb_probe.http[0].id
}

############################################
# Cloud-init
############################################

locals {
  cloud_init = <<-CLOUD
#cloud-config
package_update: true
packages:
  - nginx
runcmd:
  - systemctl enable nginx
  - systemctl start nginx
  - echo "Hello from VMSS" > /var/www/html/index.html
CLOUD
}

############################################
# VM Scale Set
############################################

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vm_size
  instances           = var.instance_count
  admin_username      = var.admin_username
  zones               = var.zones

  custom_data = base64encode(local.cloud_init)

  upgrade_mode = "Rolling"

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "${var.name}-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id

      load_balancer_backend_address_pool_ids = var.create_lb ? [azurerm_lb_backend_address_pool.bepool[0].id] : []
    }
  }

  health_probe_id = var.create_lb ? azurerm_lb_probe.http[0].id : null

  tags = var.tags
}