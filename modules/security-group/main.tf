# ==========================================
# SECURITY GROUP
# ==========================================

resource "aws_security_group" "web" {
  name        = var.security_group_name
  description = "Security group for web server"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.security_group_name
  }
}


# ==========================================
# SSH - PORT 22
# ==========================================

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.web.id

  cidr_ipv4   = var.allowed_ssh_cidr
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}


# ==========================================
# HTTP - PORT 80
# ==========================================

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}


# ==========================================
# OUTBOUND
# ==========================================

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.web.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}