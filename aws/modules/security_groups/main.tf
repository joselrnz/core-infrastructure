resource "aws_security_group" "main" {
  name_prefix = var.security_group_name
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  tags = merge({
    "Name" = var.security_group_name
  }, var.tags)
}
