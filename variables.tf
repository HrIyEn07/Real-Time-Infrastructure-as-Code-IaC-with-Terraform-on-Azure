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

variable "region_name_mapper" {
  type = map(string)
  default = {
    "eastus" = "eus"
    "westus" = "wus"
  }
}

variable "resource_group" {
    type = object({
      name = string
      id   = string
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