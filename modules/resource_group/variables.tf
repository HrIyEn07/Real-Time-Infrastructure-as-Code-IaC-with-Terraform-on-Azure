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

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}

variable "storage_account" {
  type = object({
    name                     = string
    account_tier             = string    # Standard or Premium
    account_replication_type = string    # LRS, GRS, RAGRS, ZRS, etc.
    location                 = string
    kind                     = string    # StorageV2, BlobStorage, etc.
  })
  description = "Configuration for the Azure Storage Account"
}