provider "aws" {
  region = var.aws_region
}


# ==========================================
# VPC MODULE
# ==========================================

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}


# ==========================================
# SECURITY GROUP MODULE
# ==========================================

module "security_group" {
  source = "./modules/security-group"

  vpc_id              = module.vpc.vpc_id
  security_group_name = var.security_group_name
  allowed_ssh_cidr    = var.allowed_ssh_cidr
}


# ==========================================
# UBUNTU AMI
# ==========================================

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# ==========================================
# EC2 MODULE
# ==========================================

module "ec2" {
  source = "./modules/ec2"

  ami_id = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = module.vpc.public_subnet_id

  security_group_id = module.security_group.security_group_id

  instance_name = var.instance_name
}