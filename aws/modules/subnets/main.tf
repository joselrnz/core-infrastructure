resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)

  vpc_id                  = var.vpc_id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]

  tags = merge({
    "Name" = "${var.vpc_name}-public-${count.index}"
  }, var.tags)
}

resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)

  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = var.availability_zones[count.index]

  tags = merge({
    "Name" = "${var.vpc_name}-private-${count.index}"
  }, var.tags)
}
