variable "vpc_id" {}
variable "vpc_name" {}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "availability_zones" {
  type = list(string)
}
variable "tags" {
  default = {}
}
