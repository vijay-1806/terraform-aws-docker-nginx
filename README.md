# Terraform AWS Docker Nginx Deployment

A hands-on DevOps project that demonstrates how to provision AWS infrastructure using **Terraform**, deploy an **EC2 instance**, install **Docker automatically**, and run an **Nginx container** using EC2 User Data.

The project uses Terraform modules to make the infrastructure reusable and easier to manage.

---

## Architecture

```text
                         Internet
                            │
                            ▼
                    Internet Gateway
                            │
                            ▼
                     AWS VPC
                     10.0.0.0/16
                            │
                            ▼
                    Public Subnet
                     10.0.1.0/24
                            │
                            ▼
                       EC2 Instance
                         Ubuntu
                            │
                            ▼
                         Docker
                            │
                            ▼
                    Nginx Container
                      nginx:alpine
                            │
                            ▼
                    Web Application
                         Port 80
