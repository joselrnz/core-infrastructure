# variables.tf - Root module variables
variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

# Common variables
variable "region" {
  description = "DigitalOcean region"
  type        = string
  default     = "nyc1"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = list(string)
  default     = ["terraform", "infrastructure"]
}

# VPC Variables
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "main-vpc"
}

variable "vpc_description" {
  description = "Description of the VPC"
  type        = string
  default     = "Main VPC for Kubernetes infrastructure"
}

variable "vpc_ip_range" {
  description = "IP range for the VPC in CIDR notation"
  type        = string
  default     = "10.10.0.0/16"
}

variable "create_firewall" {
  description = "Whether to create a firewall for the VPC"
  type        = bool
  default     = true
}

variable "ssh_allowed_ips" {
  description = "List of IP addresses allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "k8s_api_allowed_ips" {
  description = "List of IP addresses allowed to access Kubernetes API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "firewall_tags" {
  description = "Tags to apply to the firewall"
  type        = list(string)
  default     = ["vpc-firewall", "kubernetes"]
}

variable "create_load_balancer" {
  description = "Whether to create a load balancer"
  type        = bool
  default     = false
}

variable "ssl_certificate_name" {
  description = "Name of the SSL certificate for HTTPS"
  type        = string
  default     = ""
}

variable "healthcheck_path" {
  description = "Path for load balancer health checks"
  type        = string
  default     = "/"
}

variable "lb_droplet_tag" {
  description = "Tag to identify droplets for load balancer"
  type        = string
  default     = "k8s-worker"
}

variable "redirect_http_to_https" {
  description = "Whether to redirect HTTP traffic to HTTPS"
  type        = bool
  default     = true
}

variable "enable_proxy_protocol" {
  description = "Whether to enable proxy protocol"
  type        = bool
  default     = false
}

variable "lb_tags" {
  description = "Tags to apply to the load balancer"
  type        = list(string)
  default     = ["kubernetes", "load-balancer"]
}

variable "create_reserved_ip" {
  description = "Whether to create a reserved IP for the load balancer"
  type        = bool
  default     = false
}

variable "create_staging_vpc" {
  description = "Whether to create a separate staging VPC"
  type        = bool
  default     = false
}

variable "staging_ip_range" {
  description = "IP range for staging VPC"
  type        = string
  default     = "10.20.0.0/16"
}

# Kubernetes Variables
variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "main-k8s-cluster"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32.2-do.1"
}

variable "enable_ha" {
  description = "Enable high availability control plane"
  type        = bool
  default     = false
}

variable "auto_upgrade" {
  description = "Enable auto-upgrade for the cluster"
  type        = bool
  default     = false
}

variable "surge_upgrade" {
  description = "Enable surge upgrade"
  type        = bool
  default     = false
}

variable "pool_name" {
  description = "Name of the main node pool"
  type        = string
  default     = "main-pool"
}

variable "node_size" {
  description = "Size of the nodes (droplet size)"
  type        = string
  default     = "s-2vcpu-2gb"
}

variable "node_count" {
  description = "Number of nodes in the main pool"
  type        = number
  default     = 2
}

variable "enable_autoscale" {
  description = "Enable auto-scaling for the main node pool"
  type        = bool
  default     = false
}

variable "min_nodes" {
  description = "Minimum number of nodes when auto-scaling is enabled"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Maximum number of nodes when auto-scaling is enabled"
  type        = number
  default     = 5
}

variable "node_labels" {
  description = "Labels to apply to nodes"
  type        = map(string)
  default     = {}
}

variable "node_tags" {
  description = "Tags to apply to nodes"
  type        = list(string)
  default     = []
}

variable "cluster_tags" {
  description = "Tags to apply to the cluster"
  type        = list(string)
  default     = []
}

variable "maintenance_start_time" {
  description = "Start time for maintenance window (HH:MM format)"
  type        = string
  default     = "04:00"
}

variable "maintenance_day" {
  description = "Day of the week for maintenance"
  type        = string
  default     = "sunday"
}

variable "create_additional_pool" {
  description = "Whether to create an additional node pool"
  type        = bool
  default     = false
}

variable "additional_pool_name" {
  description = "Name of the additional node pool"
  type        = string
  default     = "additional-pool"
}

variable "additional_pool_size" {
  description = "Size of nodes in the additional pool"
  type        = string
  default     = "s-4vcpu-8gb"
}

variable "additional_pool_count" {
  description = "Number of nodes in the additional pool"
  type        = number
  default     = 1
}

variable "additional_pool_autoscale" {
  description = "Enable auto-scaling for additional pool"
  type        = bool
  default     = false
}

variable "additional_pool_min_nodes" {
  description = "Minimum nodes for additional pool auto-scaling"
  type        = number
  default     = 1
}

variable "additional_pool_max_nodes" {
  description = "Maximum nodes for additional pool auto-scaling"
  type        = number
  default     = 3
}

variable "additional_pool_labels" {
  description = "Labels for additional pool nodes"
  type        = map(string)
  default     = {}
}

variable "additional_pool_tags" {
  description = "Tags for additional pool nodes"
  type        = list(string)
  default     = []
}