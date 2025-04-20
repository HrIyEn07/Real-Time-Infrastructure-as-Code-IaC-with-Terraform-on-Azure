output "common_resource_group" {
  value = var.environment.name != "dev" ? {
    name = azurerm_resource_group.common-rg[0].name
    id   = azurerm_resource_group.common-rg[0].id
  } : null
}