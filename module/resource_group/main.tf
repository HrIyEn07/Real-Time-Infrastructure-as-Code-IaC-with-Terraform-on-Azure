resource "azurerm_resource_group" "rg" {
  name = "${var.resource_group.name}-${var.environment.name}-${var.environment.region.primary}"
  location = var.environment.region.primary
  tags = var.tags
}

