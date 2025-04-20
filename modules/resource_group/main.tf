resource "azurerm_resource_group" "common-rg" {
  count = var.environment.name != "dev" ? 1 : 0
  name = "${var.common_resource_group.name}-${var.environment.name}-${var.environment.region.primary}"
  location = var.environment.region.primary
  tags = var.tags
}

