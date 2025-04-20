module "common_resource_group" {
    source = "./modules/resource_group"
    environment = var.environment
    common_resource_group = var.common_resource_group
    tags = var.tags
}

module "storage_accounts" {
  source = "./modules/storage_account"
  storage_accounts = var.storage_accounts
  resource_group = var.resource_group
  environment = var.environment
  tags = var.tags
}

module "network" {
  source = "./modules/network"
  network_rg = var.network_rg
  environment = var.environment
  network = var.network
  tags = var.tags
}


module "virtual_machine" {
  source = "./modules/virtual-machine"
  resource_group = var.resource_group
  environment = var.environment
  virtual_machines = var.virtual_machines
  network = module.network.network
  network_rg = var.resource_group
  tags = var.tags
}
