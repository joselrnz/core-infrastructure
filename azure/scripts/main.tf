/**
 * # Azure Storage Account Deployment
 *
 * This Terraform configuration deploys an Azure Storage Account using the
 * storage module from the terraform-cloud-modules-iac repository.
 */

# Define common tags that will be applied to all resources
locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Core Infrastructure"
    Owner       = "DevOps Team"
    DeployedAt  = timestamp()
  }
}

# Use existing Resource Group
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

# Storage Account using the module from terraform-cloud-modules-iac
module "storage_account" {
  source = "git::https://github.com/joselrnz/terraform-cloud-modules-iac.git//azure/storage"

  storage_account_name      = var.storage_account_name
  resource_group_name       = data.azurerm_resource_group.this.name
  location                  = var.location
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  account_kind              = var.account_kind
  access_tier               = var.access_tier

  enable_versioning         = var.enable_versioning
  enable_delete_retention   = var.enable_delete_retention
  delete_retention_days     = var.delete_retention_days

  enable_container_delete_retention = var.enable_container_delete_retention
  container_delete_retention_days   = var.container_delete_retention_days

  containers                = var.containers

  tags                      = merge(var.tags, local.common_tags)

  depends_on = [data.azurerm_resource_group.this]
}







