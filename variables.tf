variable "environment" {
  type = object({
    name   = string
    type   = string  # dev, qa, staging, prod
    region = object({
      primary   = string
      secondary = string
    })
  })
}

variable "common_resource_group" {
  type = object({
    name = string
    location = string
  })
}


variable "resource_group" {
    type = object({
      name = string
      location = string
    })
}

variable "region_name_mapper" {
  type = map(string)
  default = {
    "eastus" = "eus"
    "westus" = "wus"
  }
}

variable "network_rg" {
    type = object({
      name = string
      location  = string
    })
}


variable "storage_accounts" {
  type = map(object({
    name              = string
    tier              = string  # Standard or Premium
    replication_type  = string  # LRS, GRS, ZRS, RAGRS, etc.
    enable_failover   = bool
    enable_backup     = bool
    backup_retention  = optional(object({
      frequency = string
      time      = string
    }))
    containers = list(object({
      name = string
    }))
  }))
  description = "Configuration for storage accounts and associated containers"
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}



# variable "virtual-machine" {
#   description = "List of VM definitions"
#   type = list(object({
#     name                = string
#     resource_group_name = string
#     subnet_id           = string
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
#   }))
# }


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
