# Creates a resource group using environment name and region
resource "azurerm_resource_group" "strg" {
  count = var.resource_group.name != null ? 1: 0
  name = "rg-${var.resource_group.name}-${var.environment.region.primary}"
  location = var.environment.region.primary
  tags = var.tags
}

# Creates storage accounts using a map input variable
resource "azurerm_storage_account" "storage" {
  for_each = var.storage_accounts                                 # Loop through each storage account entry
  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.strg[0].name
  location                 = var.environment.region.primary
  account_tier             = each.value.tier
  account_replication_type = each.value.replication_type
  tags = var.tags
}

# Creates storage containers by looping over all storage accounts and their containers, generating a unique key for each container
resource "azurerm_storage_container" "containers" {
  for_each = {
    for c in flatten([
      for sa_key, sa in var.storage_accounts : [
        for container in sa.containers : {
          key                  = "${sa_key}-${container.name}"
          name                 = container.name
          storage_account_name = sa_key
        }
      ]
    ]) : c.key => c
  }

  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.storage[each.value.storage_account_name].id
  container_access_type = "private"
}
