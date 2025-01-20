# module "vpc" {
#   source = "../../modules/vpc"
#   vpc_name = "dev-vpc"
#   vpc_cidr = "10.0.0.0/16"
#   enable_dns_support = true
#   enable_dns_hostnames = true
#   tags = { "Environment" = "dev" }
# }

# module "subnets" {
#   source = "../../modules/subnets"
#   vpc_id = module.vpc.vpc_id
#   public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
#   private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
#   availability_zones = ["us-west-2a", "us-west-2b"]
#   tags = { "Environment" = "dev" }
# }

# module "security_groups" {
#   source = "../../modules/security_groups"
#   vpc_id = module.vpc.vpc_id
#   security_group_name = "dev-sg"
#   allowed_cidr_blocks = ["0.0.0.0/0"]
#   tags = { "Environment" = "dev" }
# }
