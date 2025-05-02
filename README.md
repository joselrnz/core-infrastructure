# Core Infrastructure Repository

This repository contains the infrastructure as code (IaC) configurations for deploying core cloud resources across multiple cloud providers, with a primary focus on Azure. It follows a structured approach to organize Terraform configurations by cloud provider and environment.

## Repository Structure

```
core-infrastructure/
├── .github/workflows/    # CI/CD workflows for automated deployments
├── azure/                # Azure infrastructure configurations
│   ├── env/              # Environment-specific variable files
│   │   └── dev/          # Development environment variables
│       └── dev.tfvars    # Variable values for dev environment
│   └── scripts/          # Terraform configurations for Azure
│       ├── main.tf       # Main Terraform configuration that references modules
│       ├── variables.tf  # Variable definitions for the Azure resources
│       ├── provider.tf   # Azure provider configuration
│       ├── backend.tf    # Backend configuration for Terraform state storage
│       └── outputs.tf    # Output definitions from the deployment
└── .gitignore            # Git ignore file
```

## Azure Infrastructure Design

The Azure infrastructure in this repository follows these design principles:

### 1. Modular Architecture

The infrastructure is built using a modular approach where:
- Core Terraform configurations are stored in the `azure/scripts/` directory
- These configurations reference reusable modules from the `terraform-cloud-modules-iac` repository
- This separation allows for consistent resource deployment across environments

### 2. Environment Separation

- Environment-specific variables are stored in the `azure/env/` directory
- Each environment (dev, test, prod) has its own subdirectory with `.tfvars` files
- This allows for deploying identical infrastructure with environment-specific configurations

### 3. State Management

- Terraform state is managed using Azure Storage as the backend
- The backend configuration is defined in `azure/scripts/backend.tf`
- This ensures state is securely stored and can be accessed by CI/CD pipelines

### 4. Authentication

- Azure authentication is handled via environment variables:
  - ARM_CLIENT_ID
  - ARM_CLIENT_SECRET
  - ARM_SUBSCRIPTION_ID
  - ARM_TENANT_ID
- This approach avoids storing sensitive credentials in the codebase

## Azure Resources

The current Azure implementation includes:

### Storage Account

- Deploys an Azure Storage Account with customizable settings
- Supports blob storage with optional versioning and retention policies
- Allows creation of multiple containers with different access types
- Applies consistent tagging for resource management

## Deployment Process

### Manual Deployment

1. Navigate to the Azure scripts directory:
   ```
   cd core-infrastructure/azure/scripts
   ```

2. Initialize Terraform:
   ```
   terraform init
   ```

3. Apply the configuration with environment-specific variables:
   ```
   terraform apply -var-file=../env/dev/dev.tfvars
   ```

### CI/CD Deployment

The repository includes GitHub Actions workflows for automated deployment:

1. **Terraform Plan**: Runs on pull requests to validate changes
2. **Terraform Apply**: Runs on merge to main branch to apply changes
3. **Environment Selection**: Workflows can be parameterized to target specific environments

## Module References

The Azure configurations reference modules from the companion `terraform-cloud-modules-iac` repository:

```hcl
module "storage_account" {
  source = "../../modules/storage"  # Path to local module for development

  # In production, you would reference the Git repository:
  # source = "git::https://github.com/your-org/terraform-cloud-modules-iac.git//azure/storage?ref=v1.0.0"

  # Module parameters
  storage_account_name = var.storage_account_name
  resource_group_name  = data.azurerm_resource_group.this.name
  location             = var.location
  # Additional parameters...
}
```
