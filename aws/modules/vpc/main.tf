resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge({
    "Name" = var.vpc_name
  }, var.tags)
}

output "vpc_id" {
  value = aws_vpc.main.id
}
