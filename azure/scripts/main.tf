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
    #DeployedAt  = timestamp()
  }
}

# Use existing Resource Group
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

# Storage Account using the local module instead of remote Git source
module "storage_account" {
  source = "../../modules/storage" # Path to your local module
  # source = "git::https://github.com/your-org/terraform-cloud-modules-iac.git//azure/storage?ref=develop"
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

  tags = merge(var.tags, local.common_tags)

  depends_on = [data.azurerm_resource_group.this]
}








module "networking" {
  source = "../../modules/network-core"

  vnet_name           = "vnet-core-dev"
  vnet_address_space  = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = "rg-hub-dev"

  subnets = {
    public = {
      name           = "public-subnet"
      address_prefix = "10.0.1.0/24"
      security_group = ""
    }
    private = {
      name           = "private-subnet"
      address_prefix = "10.0.2.0/24"
      security_group = ""
    }
  }

  route_tables = {
    public = {
      name = "public-rt"
      routes = [
        {
          name                   = "internet-route"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "Internet"
          next_hop_in_ip_address = null
        }
      ]
    }
    private = {
      name = "private-rt"
      routes = [
        {
          name                   = "default-route"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.0.1.4"
        }
      ]
    }
  }

  tags = {
    Environment = "Production"
    Owner       = "Infrastructure Team"
  }
}