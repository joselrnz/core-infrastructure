variable "security_group_name" {}
variable "vpc_id" {}
variable "allowed_cidr_blocks" {
  default = ["0.0.0.0/0"]
}
variable "tags" {
  default = {}
}
