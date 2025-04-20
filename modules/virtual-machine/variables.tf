variable "environment" {
  description = "Environment-specific details (e.g., region, environment type)"
  type = object({
    name   = string
    type   = string  # dev, qa, staging, prod
    region = object({
      primary   = string
      secondary = string
    })
  })
}

variable "resource_group" {
    type = object({
      name = string
      location   = string
    })
}
######################
# variable "virtual_machines" {
#   description = "Map of virtual machine configurations"
#   type = map(object({
#     name                = string
#     resource_group_name = string
#     type                = string
#     vm_size             = string
#     disk_size_gb        = number
#     image = object({
#       publisher = string
#       offer     = string
#       sku       = string
#       version   = string
#     })
#     username = string
#     password = string
#     public_ip = object({
#       enabled = bool
#     })
#   }))
# }



# variable "network" {
#   description = "Network-related variables including VNet, Subnet, and NSG"
#   type = object({
#     vnet_name         = string
#     subnet_name       = string
#     subnet_id         = string
#     nsg_name          = string
#     nsg_rules         = list(object({
#       name                       = string
#       priority                   = number
#       direction                  = string
#       access                     = string
#       protocol                   = string
#       source_port_range          = string
#       destination_port_range     = string
#       source_address_prefix      = string
#       destination_address_prefix = string
#     }))
#   })
# }



variable "tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}



variable "network_rg" {
  description = "Resource group name and ID"
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
    subnet_id = string
    address_prefixes = list(string)
    nsg_name         = string
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


variable "virtual_machines" {
  description = "Map of virtual machine configurations"
  type = map(object({
    name                = string
    resource_group_name = string
    type                = string
    vm_size             = string
    disk_size_gb        = number
    image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    username   = string
    password   = string
    public_ip  = object({
      enabled = bool
    })
    private_ip = optional(string) # Optional static private IP
  }))
}
