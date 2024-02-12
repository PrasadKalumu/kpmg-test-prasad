# Network interface Module #

# Variable declaration #

variable "name" {
  type = string
  description = "Name of the network interface card"
}

variable "location" {
  type = string
  description = "Location of the network interface card"
}

variable "resource_group_name" {
  type = string
  description = "resource group for the network interfacr card"
}

variable "subnet_id" {
  type = string
  description = "subnet id for the network interface card"
}


# Resource creation Block #

resource "azurerm_network_interface" "nic" {
  name = var.name
  location = var.location
  resource_group_name = var.resource_group_name
  
  ip_configuration {
    name = "${var.name}-ip-cfg"
    subnet_id = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Output Block

output "nic-id" {
  value = azurerm_network_interface.nic.id
}

output "nic-prt-ip" {
  value = azurerm_network_interface.nic.private_ip_address
  
}