variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to access SSH"
  type        = string
}