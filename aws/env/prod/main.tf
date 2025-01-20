# module "vpc" {
#   source = "../../modules/vpc"
#   vpc_name = "prod-vpc"
#   vpc_cidr = "10.1.0.0/16"
#   enable_dns_support = true
#   enable_dns_hostnames = true
#   tags = { "Environment" = "prod" }
# }

# module "subnets" {
#   source = "../../modules/subnets"
#   vpc_id = module.vpc.vpc_id
#   public_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
#   private_subnets = ["10.1.3.0/24", "10.1.4.0/24"]
#   availability_zones = ["us-east-1a", "us-east-1b"]
#   tags = { "Environment" = "prod" }
# }

# module "security_groups" {
#   source = "../../modules/security_groups"
#   vpc_id = module.vpc.vpc_id
#   security_group_name = "prod-sg"
#   allowed_cidr_blocks = ["10.1.0.0/16"]
#   tags = { "Environment" = "prod" }
# }
