### Variables   ###

variable "app" {
  type        = string
  description = "Name of the application"

}

variable "loc" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "eastus"
}

variable "env" {
  type        = string
  description = "Application environment"
}

variable "address_space" {
  type        = list(string)
  description = "virtual network address space"

}

variable "snet_address_space" {
  type        = list(string)
  description = "subnets addresses"

}

variable "size" {
  type        = string
  description = "compute vm sku"
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Admin user to the VM"
  default     = "kpsdadmin"
}

