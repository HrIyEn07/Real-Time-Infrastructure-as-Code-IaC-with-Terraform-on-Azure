module "resource_group" {
    source = "./module/resource_group"
    environment = var.environment
    resource_group = var.resource_group
    tags = var.tags
}


module "storage_accounts" {
  source = "./module/storage_account"
  resource_group = var.resource_group
  storage_accounts = var.storage_accounts
  environment = var.environment
  tags = var.tags
}