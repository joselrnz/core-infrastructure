# My Development Environment Configuration

# Azure Provider Authentication
# NOTE: Do NOT set sensitive credentials in this file!
# Use environment variables or a secret store instead:
# - ARM_CLIENT_ID
# - ARM_CLIENT_SECRET
# - ARM_SUBSCRIPTION_ID
# - ARM_TENANT_ID
#
# For CI/CD pipelines, use secure variables or key vault references

# General
environment         = "dev"
location            = "eastus"
resource_group_name = "data-dp203"

# # Tags
tags = {
  Environment = "Development"
  # ManagedBy   = "Terraform"
  Project = "My Application"
  Owner   = "DevOps Team"
  # BusinessUnit       = "IT"
}

# Storage Account Configuration
storage_account_name     = "stkafkajoselrnz"
account_tier             = "Standard"
account_replication_type = "LRS"
account_kind             = "StorageV2"
access_tier              = "Hot"
enable_versioning        = true
enable_delete_retention  = true
delete_retention_days    = 14

# Storage Containers
containers = [
  {
    name        = "data"
    access_type = "private"
  },
  {
    name        = "backups"
    access_type = "private"
  },
  {
    name        = "logs"
    access_type = "private"
  }
]
