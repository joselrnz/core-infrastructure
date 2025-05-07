module "vpc" {
  source       = "../../modules/vpc"
  vpc_name     = var.vpc_name
  region       = var.region
  vpc_ip_range = var.vpc_ip_range
  trusted_ip   = var.trusted_ip
  cluster_name = var.cluster_name
}

module "kubernetes" {
  source                 = "../../modules/kubernetes"
  vpc_id                 = module.vpc.vpc_id
  region                 = var.region
  cluster_name           = var.cluster_name
  kubernetes_version     = var.kubernetes_version
  high_availability      = var.high_availability
  node_size              = var.node_size
  min_nodes              = var.min_nodes
  max_nodes              = var.max_nodes
  spaces_bucket_name     = var.spaces_bucket_name
  spaces_access_key      = var.spaces_access_key
  spaces_secret_key      = var.spaces_secret_key
  application_namespaces = var.application_namespaces
  enable_ssl             = var.enable_ssl
  domain_name            = var.domain_name
  admin_email            = "admin@${var.domain_name}"
}




