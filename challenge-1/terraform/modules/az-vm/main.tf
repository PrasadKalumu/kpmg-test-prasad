# Virtual machine Module #

# Variables Declaration #

variable "name" {
  type        = string
  description = "Name of the virtual machine name"
}

variable "resource_group_name" {
  type = string
  description = "Resource group name of vm to create"
}

variable "location" {
  type        = string
  description = "Location of the virtual machine created"
  default     = "Eastus"
}

variable "size" {
  type        = string
  description = "compute vm sku"
  default     = "Standard_B1s"
}

variable "network_interface_ids" {
  type = list(string)
  description = "List of network card ids to add to VM "
}

variable "admin_username" {
  type = string
  description = "Admin user to the VM"
}

variable "public-key" {
  type = string
  description = "Public key for VM to connect"
  default = "C:\\Users\\User/.ssh/id_rsa.pub"
}

variable "os-disk-stg-type" {
  type = string
  description = "OS disk storage type"
  default = "Standard_LRS"
}

variable "tags" {
  type = map(string)
  description = "Tags for the VM"
}
# Resource creation Blocks #

resource "azurerm_linux_virtual_machine" "lx-vm" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  network_interface_ids = var.network_interface_ids
  admin_username        = var.admin_username
  #computer_name         = var.name
  tags                  = var.tags
  
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public-key)
  }
  os_disk {
    name                 = "OsDisk-${var.name}"
    caching              = "ReadWrite"
    storage_account_type = var.os-disk-stg-type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

}

# Output Block #

output "lx-vm-id" {
  value = azurerm_linux_virtual_machine.lx-vm.id
  description = "ID if the Linux VM"
}

output "lx-vm-prt-prm-adrs" {
  value = azurerm_linux_virtual_machine.lx-vm.private_ip_address
  description = "VM private primary ip address"
}