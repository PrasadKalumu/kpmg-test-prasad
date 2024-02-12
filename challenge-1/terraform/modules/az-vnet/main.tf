# Virtual Network Module #

# Variable declaration #
variable "name" {
  type        = string
  description = "Name of the virtual network"
}

variable "resource_group_name" {
  type        = string
  description = "resource group for virtual network"

}

variable "location" {
  type        = string
  description = "Location of the network"
}

variable "address_space" {
  type        = list(string)
  description = "List of ip network address "
}

variable "snet_names" {
  type        = map(string)
  description = "Virtual network subnet name to create"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Virtual network tags"
  default     = {}
}

# Resource creation Blocks #

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  tags                = var.tags

  dynamic "subnet" {
    for_each = var.snet_names
    content {
      name           = subnet.key
      address_prefix = subnet.value
    }
  }

}

# Output Block #

output "vnet-id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Virtual network id"
}

output "vnet-name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Virtual network name"
}

output "vnet-adrs" {
  value = azurerm_virtual_network.vnet.address_space
}

output "snet-id" {
  value = azurerm_virtual_network.vnet.subnet[*].id
  
}

output "snet-name" {
  value = azurerm_virtual_network.vnet.subnet[*].name
  
}