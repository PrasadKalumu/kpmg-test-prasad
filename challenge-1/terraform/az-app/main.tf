
# locals block
locals {
  prefix = "${var.app}-${var.loc}-${var.env}"

  snets = {
    "web" = var.snet_address_space[0]
    "app" = var.snet_address_space[1]
    "db"  = var.snet_address_space[2]
  }

  vm_nic = {
    "web" = 0
    "app" = 1
    "db"  = 2
  }

  tags = {
    "app"   = var.app
    "loc"   = var.loc
    "env"   = var.env
    "owner" = "Prasad"
  }


}
# create resource group 
module "rg" {
  source   = "../modules/az-rg"
  name     = "${local.prefix}-rg"
  location = var.loc
  tags     = local.tags
}

# create virtual network
module "vnet" {
  source              = "../modules/az-vnet"
  name                = "${local.prefix}-vnet"
  resource_group_name = module.rg.rg-name
  location            = module.rg.rg-loc
  address_space       = var.address_space
  snet_names          = local.snets
  tags                = local.tags

}

# create network interfaces

module "nic" {
  source              = "../modules/az-nic"
  for_each            = local.vm_nic
  name                = "${each.key}-nic"
  resource_group_name = module.rg.rg-name
  location            = module.rg.rg-loc
  subnet_id           = module.vnet.snet-id[each.value]
}


# create virtual machines 

module "vm" {
  source = "../modules/az-vm"
  #for_each              = local.vm_nic
  name                  = "web-vm" #"${each.key}-vm"
  resource_group_name   = module.rg.rg-name
  location              = module.rg.rg-loc
  size                  = var.size
  network_interface_ids = [module.nic["web"].nic-id] #[ module.nic[each.key].nic-id ]
  admin_username        = var.admin_username
  tags                  = local.tags

}


output "snet-id" {
  value = module.vnet.snet-id

}

output "snet-name" {
  value = module.vnet.snet-name

}

