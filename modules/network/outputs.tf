output "network" {
  description = "Flat network output structure for VM module input"
  value = {
    vnet_name        = var.network.vnet_name
    address_space    = var.network.address_space
    subnet_name      = var.network.subnet_name
    address_prefixes = var.network.address_prefixes
    nsg_name         = var.network.nsg_name
    nsg_rules        = var.network.nsg_rules

    # Dynamically retrieved values
    subnet_id        = var.network.created_network ? azurerm_subnet.subnet[0].id : null
    created_network  = var.network.created_network

    resource_group = {
      name     = var.network.resource_group.name
      location = var.network.resource_group.location
    }
  }
}
