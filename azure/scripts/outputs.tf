# Resource Group outputs
output "resource_group_id" {
  description = "The ID of the resource group"
  value       = data.azurerm_resource_group.this.id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = data.azurerm_resource_group.this.name
}

# Storage Account outputs
output "storage_account_id" {
  description = "The ID of the storage account"
  value       = module.storage_account.storage_account_id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = module.storage_account.storage_account_name
}

output "primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location"
  value       = module.storage_account.primary_blob_endpoint
}

output "containers" {
  description = "Map of containers"
  value       = module.storage_account.containers
}


output "role_assignment_ids" {
  value = [for ra in azurerm_role_assignment.dynamic : ra.id]
}