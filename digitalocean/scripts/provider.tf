provider "digitalocean" {
  token = var.do_token
}


terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean" # ✅ Correct
      version = "~> 2.24"
    }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = "~> 2.20"
    # }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = "~> 2.9"
    # }
  }
}