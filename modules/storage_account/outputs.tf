# Output for resource group
output "resource_group" {
  value = var.resource_group.name != null ? {
    name = azurerm_resource_group.strg[0].name
    id   = azurerm_resource_group.strg[0].id
  } : null
}

# Output for Storage Accounts
output "storage_accounts" {
  description = "List of created storage accounts with their names and IDs"
  value = {
    for sa in azurerm_storage_account.storage : sa.name => {
      id   = sa.id
      name = sa.name
    }
  }
}

# Output for Storage Containers
output "storage_containers" {
  description = "List of created storage containers with their storage account mapping"
  value = {
    for container in azurerm_storage_container.containers :
    "${container.storage_account_id}-${container.name}" => { # Ensuring uniqueness
      storage_account_id = container.storage_account_id
      id                 = container.id
      name               = container.name
    }
  }
}
