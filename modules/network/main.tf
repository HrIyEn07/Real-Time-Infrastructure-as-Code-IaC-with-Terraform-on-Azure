resource "azurerm_resource_group" "network-rg" {
  count    = var.network.resource_group.name != null ? 1 : 0
  name     = var.network.resource_group.name
  location = var.network.resource_group.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  count               = var.network.created_network ? 1 : 0
  name                = var.network.vnet_name
  address_space       = var.network.address_space
  location            = azurerm_resource_group.network-rg[0].location
  resource_group_name = azurerm_resource_group.network-rg[0].name
}

resource "azurerm_subnet" "subnet" {
  count               = var.network.created_network ? 1 : 0
  name                = var.network.subnet_name
  resource_group_name = azurerm_resource_group.network-rg[0].name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes    = var.network.address_prefixes
}

resource "azurerm_network_security_group" "nsg" {
  count               = var.network.created_network ? 1 : 0
  name                = var.network.nsg_name
  location            = azurerm_resource_group.network-rg[0].location
  resource_group_name = azurerm_resource_group.network-rg[0].name

  dynamic "security_rule" {
    for_each = var.network.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  count                     = var.network.created_network ? 1 : 0
  subnet_id                 = azurerm_subnet.subnet[0].id
  network_security_group_id = azurerm_network_security_group.nsg[0].id
}
