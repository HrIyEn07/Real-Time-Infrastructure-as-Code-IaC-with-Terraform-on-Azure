variable "environment" {
  description = "Details about the environment like name and region"
  type = object({
    name   = string
    type   = string  # dev, qa, staging, prod
    region = object({
      primary   = string
      secondary = string
    })
  })
}

variable "network_rg" {
  description = "Resource group name and location"
  type = object({
    name = string
    location = string
  })
}

variable "network" {
  description = "Network-related variables including VNet, Subnet, and NSG"
  type = object({
    vnet_name        = string
    address_space    = list(string)
    subnet_name      = string
    address_prefixes = list(string)
    nsg_name         = string
    created_network  = bool
    resource_group = object({
      name = string
      location = string
    })
    nsg_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  })
}


variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}
