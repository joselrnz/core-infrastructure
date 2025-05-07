# Azure Infrastructure Scripts

This directory contains the Terraform configurations for deploying Azure infrastructure resources. The configurations are designed to reference reusable modules from the `terraform-cloud-modules-iac` repository.

## Files Overview

- **main.tf**: Primary configuration file that references modules and defines the resources to be deployed
- **variables.tf**: Defines all input variables used by the Terraform configurations
- **provider.tf**: Contains the Azure provider configuration
- **backend.tf**: Configures the Terraform state backend (Azure Storage)
- **outputs.tf**: Defines outputs from the deployment

## Current Implementation

The current implementation deploys an Azure Storage Account with the following features:

- Customizable storage account settings (tier, replication type, account kind)
- Optional blob versioning
- Optional delete retention policies for blobs and containers
- Creation of multiple storage containers with different access types
- Consistent tagging for resource management

## Module Reference

The configuration references the storage module from the `terraform-cloud-modules-iac` repository:

```hcl
module "storage_account" {
  source = "../../modules/storage"  # Path for local development

  storage_account_name              = var.storage_account_name
  resource_group_name               = data.azurerm_resource_group.this.name
  location                          = var.location
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  account_kind                      = var.account_kind
  access_tier                       = var.access_tier
  enable_versioning                 = var.enable_versioning
  enable_delete_retention           = var.enable_delete_retention
  delete_retention_days             = var.delete_retention_days
  enable_container_delete_retention = var.enable_container_delete_retention
  container_delete_retention_days   = var.container_delete_retention_days

  containers = var.containers
  tags       = merge(var.tags, local.common_tags)
}
```

## Authentication

The configuration uses environment variables for authentication to Azure:

- ARM_CLIENT_ID
- ARM_CLIENT_SECRET
- ARM_SUBSCRIPTION_ID
- ARM_TENANT_ID

This approach avoids storing sensitive credentials in the codebase.

## Usage

### Prerequisites

1. Azure CLI installed and configured
2. Terraform CLI installed (version >= 1.3.0)
3. Access to an Azure subscription
4. Service Principal with appropriate permissions

### Deployment Steps

1. Set the required environment variables for Azure authentication in PowerShell:

```bash
$ARM_CLIENT_ID = "your-client-id"
$ARM_CLIENT_SECRET = "your-client-secret"
$ARM_SUBSCRIPTION_ID = "your-subscription-id"
$ARM_TENANT_ID = "your-tenant-id"
```

2. Initialize Terraform:

```bash
terraform init
```

3. Plan the deployment:

```bash
terraform plan -var-file=../env/dev/dev.tfvars
```

4. Apply the configuration:

```bash
terraform apply -var-file=../env/dev/dev.tfvars
```

### Backend Configuration

The backend configuration in `backend.tf` is partially commented out. To use Azure Storage as a backend, uncomment and provide the required values:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "your-resource-group"
    storage_account_name = "your-storage-account"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
```

Alternatively, you can provide these values via a backend configuration file or command-line parameters during initialization:

```bash
terraform init `
  -backend-config="resource_group_name=your-resource-group" `
  -backend-config="storage_account_name=your-storage-account" `
  -backend-config="container_name=tfstate" `
  -backend-config="key=terraform.tfstate"
```
