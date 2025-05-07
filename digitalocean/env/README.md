# Azure Environment Variables

This directory contains environment-specific variable files (`.tfvars`) for Azure infrastructure deployments. These files provide values for the variables defined in the Terraform configurations.

## Directory Structure

```
env/
├── dev/                # Development environment
│   └── dev.tfvars      # Variable values for development
├── test/               # Test environment (future)
│   └── test.tfvars     # Variable values for test
└── prod/               # Production environment (future)
    └── prod.tfvars     # Variable values for production
```

## Purpose

The environment-specific variable files serve several important purposes:

1. **Environment Separation**: Maintain different configurations for development, testing, and production environments
2. **Configuration Management**: Store environment-specific values outside of the main Terraform code
3. **Deployment Consistency**: Ensure the same infrastructure is deployed across environments with appropriate variations
4. **Version Control**: Track changes to environment configurations over time

## Usage

When applying Terraform configurations, specify the appropriate variable file for the target environment:

```bash
# For development environment
terraform apply -var-file=../env/dev/dev.tfvars

# For test environment (when available)
terraform apply -var-file=../env/test/test.tfvars

# For production environment (when available)
terraform apply -var-file=../env/prod/prod.tfvars
```

## Variable File Format

Each `.tfvars` file contains key-value pairs that correspond to the variables defined in the `variables.tf` file:

```hcl
# General variables
environment         = "dev"
location            = "eastus"
resource_group_name = "rg-storage-dev"

# Storage Account variables
storage_account_name              = "stdevunique12345"
account_tier                      = "Standard"
account_replication_type          = "LRS"
account_kind                      = "StorageV2"
access_tier                       = "Hot"
enable_versioning                 = true
enable_delete_retention           = true
delete_retention_days             = 7
enable_container_delete_retention = true
container_delete_retention_days   = 7

# Container configurations
containers = [
  {
    name        = "tfstate"
    access_type = "private"
  },
  {
    name        = "data"
    access_type = "private"
  }
]

# Resource tagging
tags = {
  Environment = "Development"
  Project     = "Infrastructure"
  Owner       = "DevOps Team"
}
```

## Best Practices

1. **Naming Conventions**: Use consistent naming conventions across environments
2. **Minimal Differences**: Keep differences between environments to a minimum
3. **Sensitive Data**: Do not store sensitive data (passwords, keys) in these files
4. **Documentation**: Document any non-obvious variable values
5. **Review Changes**: Carefully review changes to production environment variables
