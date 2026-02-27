variable "name" {
    type        = string
    description = "Name of the virtual machine scale set"
    default     = "my-vmss"
}

variable "location" {
    type        = string
    description = "Azure region for the virtual machine scale set"
}

variable "resource_group_name" {
    type        = string
    description = "Name of the resource group where the virtual machine scale set will be created"
}

variable "subnet_id" {
    type        = string
    description = "ID of the subnet where the virtual machine scale set will be deployed"
}

variable "instance_count" {
    type        = number
    description = "Number of instances in the virtual machine scale set"
    default     = 2
}

variable "vm_size" {
    type        = string
    description = "Size of the virtual machine instances in the scale set"
    default     = "Standard_DS1_v2"
}

variable "admin_username" {
    type        = string
    description = "Admin username for the virtual machine instances"
    default     = "azureuser"
}

variable "admin_password" {
    type        = string
    description = "Admin password for the virtual machine instances"
    default     = "P@ssw0rd1234"
}

variable "ssh_public_key" {
    type        = string
    description = "SSH public key for authentication to the virtual machine instances"
}   

variable "zones" {
    type        = list(string)
    description = "List of availability zones for the virtual machine scale set instances"
    default     = []
}

variable "create_public_ip" {
    type        = bool
    description = "Flag to determine whether to create public IP addresses for the virtual machine scale set instances"
    default     = false
}   

variable "lb_sku" {
    type        = string
    description = "SKU of the load balancer to be associated with the virtual machine scale set"
    default     = "Standard"
}

variable "tags" {
    type        = map(string)
    description = "Tags to be applied to the virtual machine scale set"
    default     = {}
}

variable "create_lb_public_ip" {
    type        = bool
    description = "Flag to determine whether to create public IP addresses for the load balancer"
    default     = false

}

variable "create_lb" {
    type        = bool
    description = "Flag to determine whether to create a load balancer for the virtual machine scale set"
    default     = false
}

variable "create_public_ip" {
  type = bool
  description = "Flag to determine whether to create public IP addresses for the virtual machine scale set instances"
  default = false
}