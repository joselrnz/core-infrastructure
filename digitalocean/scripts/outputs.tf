# outputs.tf - Root module outputs

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_name" {
  description = "Name of the VPC"
  value       = module.vpc.vpc_name
}

output "vpc_ip_range" {
  description = "IP range of the VPC"
  value       = module.vpc.vpc_ip_range
}

output "vpc_region" {
  description = "Region of the VPC"
  value       = module.vpc.vpc_region
}

output "firewall_id" {
  description = "ID of the VPC firewall"
  value       = module.vpc.firewall_id
}

output "load_balancer_ip" {
  description = "IP address of the load balancer"
  value       = module.vpc.load_balancer_ip
}

# Kubernetes Outputs
output "cluster_id" {
  description = "ID of the Kubernetes cluster"
  value       = module.kubernetes.cluster_id
}

output "cluster_name" {
  description = "Name of the Kubernetes cluster"
  value       = module.kubernetes.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint of the Kubernetes cluster"
  value       = module.kubernetes.cluster_endpoint
}

output "cluster_version" {
  description = "Version of the Kubernetes cluster"
  value       = module.kubernetes.cluster_version
}

output "cluster_status" {
  description = "Status of the Kubernetes cluster"
  value       = module.kubernetes.cluster_status
}

output "cluster_ipv4" {
  description = "Public IPv4 address of the Kubernetes cluster"
  value       = module.kubernetes.cluster_ipv4
}

# Kubeconfig (sensitive)
output "kube_config" {
  description = "Kubernetes configuration for connecting to the cluster"
  value       = module.kubernetes.kube_config
  sensitive   = true
}

# Connection information
output "connection_info" {
  description = "Information needed to connect to your infrastructure"
  value = {
    cluster_endpoint = module.kubernetes.cluster_endpoint
    vpc_ip_range     = module.vpc.vpc_ip_range
    region           = var.region
    load_balancer_ip = module.vpc.load_balancer_ip
  }
}

# Cost information
output "estimated_monthly_cost" {
  description = "Estimated monthly cost breakdown"
  value = {
    kubernetes_nodes = "~$${var.node_count * 12} (${var.node_count} x ${var.node_size})"
    high_availability = var.enable_ha ? "~$40 (HA control plane)" : "$0 (HA disabled)"
    load_balancer = var.create_load_balancer ? "~$12 (Load Balancer)" : "$0 (No LB)"
    total_estimate = "~$${var.node_count * 12 + (var.enable_ha ? 40 : 0) + (var.create_load_balancer ? 12 : 0)}"
  }
}