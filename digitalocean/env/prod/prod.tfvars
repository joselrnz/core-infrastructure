# terraform.tfvars - Main configuration file

# DigitalOcean API Token (set via environment variable instead)
# do_token = "your-digitalocean-api-token-here"

# Common settings
region = "nyc1"
common_tags = [
  "terraform",
  "infrastructure",
  "production"
]

# VPC Configuration
vpc_name        = "production-vpc"
vpc_description = "Production VPC for Kubernetes cluster"
vpc_ip_range    = "10.10.0.0/16"

# Security settings
create_firewall = true
ssh_allowed_ips = [
  "203.0.113.0/24",  
  "198.51.100.0/24" 
]
k8s_api_allowed_ips = [
  "203.0.113.0/24",  
  "198.51.100.0/24" 
]

firewall_tags = [
  "production",
  "vpc-firewall",
  "kubernetes"
]

# Load Balancer (optional)
create_load_balancer    = false  # Set to true if you need external LB
ssl_certificate_name    = ""     # Create SSL cert in DO first
healthcheck_path        = "/health"
lb_droplet_tag         = "k8s-worker"
redirect_http_to_https = true
enable_proxy_protocol  = false

lb_tags = [
  "production",
  "kubernetes",
  "load-balancer"
]

create_reserved_ip = false  # Set to true for stable IP

# Staging environment (optional)
create_staging_vpc = false
staging_ip_range   = "10.20.0.0/16"

# Kubernetes Configuration
cluster_name = "production-k8s"
k8s_version  = "1.32.2-do.1"

# Production settings
enable_ha     = false  # Set to true for production ($40/month extra)
auto_upgrade  = true   # Recommended for security updates
surge_upgrade = true

# Main node pool
pool_name  = "main-workers"
node_size  = "s-2vcpu-4gb"  # Adjust based on your needs
node_count = 3              # Odd number recommended for HA

# Auto-scaling
enable_autoscale = true
min_nodes        = 2
max_nodes        = 10

# Node configuration
node_labels = {
  "environment" = "production"
  "team"        = "platform"
  "role"        = "worker"
}

node_tags = [
  "production",
  "kubernetes",
  "workers"
]

cluster_tags = [
  "production",
  "kubernetes",
  "main-cluster"
]

# Maintenance window (adjust to your timezone)
maintenance_start_time = "03:00"  # 3 AM
maintenance_day        = "sunday"

# Additional node pool (for specialized workloads)
create_additional_pool = false

# If you enable additional pool, configure these:
additional_pool_name        = "gpu-workers"
additional_pool_size        = "g-2vcpu-8gb"
additional_pool_count       = 1
additional_pool_autoscale   = true
additional_pool_min_nodes   = 0
additional_pool_max_nodes   = 3

additional_pool_labels = {
  "workload-type" = "gpu"
  "environment"   = "production"
}

additional_pool_tags = [
  "production",
  "gpu",
  "special-workloads"
]