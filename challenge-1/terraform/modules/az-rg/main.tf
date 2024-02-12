# Resource Group Module #

# Variables Declaration #

variable "name" {
  type        = string
  description = "Name of resource group to be created"
}

variable "location" {
  type        = string
  description = "region of the resources"
  default     = "Eastus"
}

variable "tags" {
  type        = map(string)
  description = "resource group tags"
  default     = {}
}

# Resource creation Blocks #

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

# Output Block #

output "rg-name" {
  value = azurerm_resource_group.rg.name
}

output "rg-loc" {
  value = azurerm_resource_group.rg.location
}

output "rg-id" {
  value = azurerm_resource_group.rg.id
}