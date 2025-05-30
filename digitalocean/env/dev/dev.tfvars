ssh_public_key_path    = "~/.ssh/id_rsa.pub"
vpc_name               = "dev-vpc"
region                 = "nyc3"
vpc_ip_range           = "10.10.0.0/16"
cluster_name           = "dev-cluster"
kubernetes_version     = "1.32.2-do.0"
high_availability      = true
node_size              = "s-1vcpu-2gb"
min_nodes              = 1
max_nodes              = 1
spaces_bucket_name     = "my-space"
spaces_access_key      = "REPLACE_ME"
spaces_secret_key      = "REPLACE_ME"
application_namespaces = ["dev", "monitoring"]
enable_ssl             = true
domain_name            = "joselrnz.com"
