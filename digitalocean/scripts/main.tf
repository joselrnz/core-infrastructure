# main.tf - Root module that orchestrates VPC and Kubernetes
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.24"
    }
  }
}


# VPC Module
module "vpc" {
  source = "../../modules/vpc"
  
  # Basic VPC configuration
  vpc_name        = var.vpc_name
  region          = var.region
  vpc_description = var.vpc_description
  ip_range        = var.vpc_ip_range
  
  # Security settings
  create_firewall     = var.create_firewall
  ssh_allowed_ips     = var.ssh_allowed_ips
  k8s_api_allowed_ips = var.k8s_api_allowed_ips
  firewall_tags       = var.firewall_tags
  
  # Load Balancer settings (optional)
  create_load_balancer    = var.create_load_balancer
  ssl_certificate_name    = var.ssl_certificate_name
  healthcheck_path        = var.healthcheck_path
  lb_droplet_tag         = var.lb_droplet_tag
  redirect_http_to_https = var.redirect_http_to_https
  enable_proxy_protocol  = var.enable_proxy_protocol
  lb_tags                = var.lb_tags
  
  # Reserved IP
  create_reserved_ip = var.create_reserved_ip
  
  # Staging environment
  create_staging_vpc = var.create_staging_vpc
  staging_ip_range   = var.staging_ip_range
  
  # Common tags
  common_tags = var.common_tags
}

# Kubernetes Module
module "kubernetes" {
  source = "../../modules/kubernetes"
  
  # Dependency - VPC must be created first
  depends_on = [module.vpc]
  
  # Basic cluster configuration
  cluster_name = var.cluster_name
  region       = var.region
  k8s_version  = var.k8s_version
  vpc_id       = module.vpc.vpc_id  # Reference VPC from the vpc module
  
  # High availability and upgrade settings
  enable_ha     = var.enable_ha
  auto_upgrade  = var.auto_upgrade
  surge_upgrade = var.surge_upgrade
  
  # Main node pool configuration
  pool_name  = var.pool_name
  node_size  = var.node_size
  node_count = var.node_count
  
  # Auto-scaling configuration
  enable_autoscale = var.enable_autoscale
  min_nodes        = var.min_nodes
  max_nodes        = var.max_nodes
  
  # Node labeling and tagging
  node_labels   = var.node_labels
  node_tags     = var.node_tags
  cluster_tags  = var.cluster_tags
  
  # Maintenance window
  maintenance_start_time = var.maintenance_start_time
  maintenance_day        = var.maintenance_day
  
  # Additional node pool configuration
  create_additional_pool      = var.create_additional_pool
  additional_pool_name        = var.additional_pool_name
  additional_pool_size        = var.additional_pool_size
  additional_pool_count       = var.additional_pool_count
  additional_pool_autoscale   = var.additional_pool_autoscale
  additional_pool_min_nodes   = var.additional_pool_min_nodes
  additional_pool_max_nodes   = var.additional_pool_max_nodes
  additional_pool_labels      = var.additional_pool_labels
  additional_pool_tags        = var.additional_pool_tags
}