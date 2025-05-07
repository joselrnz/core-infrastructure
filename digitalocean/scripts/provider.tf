terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.24"
    }
  }
}
provider "digitalocean" {
  token = var.do_token
}
