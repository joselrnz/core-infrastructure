variable "do_token" {
  description = "DigitalOcean access token"
  type        = string
  sensitive   = true
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key file"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "region" {
  description = "DigitalOcean region (e.g. nyc3)"
  type        = string
}

variable "vpc_ip_range" {
  description = "IP range for the VPC (e.g. 10.10.0.0/16)"
  type        = string
}

variable "trusted_ip" {
  description = "Your public IP in CIDR notation (e.g. 203.0.113.5/32)"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "DigitalOcean Kubernetes version (e.g. 1.29.1-do.0)"
  type        = string
}

variable "high_availability" {
  description = "Enable HA for the cluster"
  type        = bool
}

variable "node_size" {
  description = "Droplet size for each node (e.g. s-2vcpu-4gb)"
  type        = string
}

variable "min_nodes" {
  description = "Minimum number of nodes"
  type        = number
}

variable "max_nodes" {
  description = "Maximum number of nodes"
  type        = number
}

variable "spaces_bucket_name" {
  description = "Name of your Spaces bucket"
  type        = string
}

variable "spaces_access_key" {
  description = "Access key for DigitalOcean Spaces"
  type        = string
  sensitive   = true
}

variable "spaces_secret_key" {
  description = "Secret key for DigitalOcean Spaces"
  type        = string
  sensitive   = true
}

variable "application_namespaces" {
  description = "List of Kubernetes namespaces to create"
  type        = list(string)
}

variable "enable_ssl" {
  description = "Whether to enable SSL (e.g. for cert-manager)"
  type        = bool
}

variable "domain_name" {
  description = "Base domain name for ingress and certs"
  type        = string
}
