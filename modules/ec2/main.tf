resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  user_data = <<-EOF
    #!/bin/bash

    # ==========================================
    # UPDATE SYSTEM
    # ==========================================

    apt-get update -y


    # ==========================================
    # INSTALL DOCKER
    # ==========================================

    apt-get install -y docker.io

    systemctl enable docker
    systemctl start docker


    # ==========================================
    # CREATE WEBSITE DIRECTORY
    # ==========================================

    mkdir -p /home/ubuntu/web


    # ==========================================
    # CREATE HTML PAGE
    # ==========================================

    cat > /home/ubuntu/web/index.html <<'HTML'

    <!DOCTYPE html>
    <html lang="en">

    <head>

      <meta charset="UTF-8">

      <meta name="viewport"
            content="width=device-width, initial-scale=1.0">

      <title>Terraform DevOps Project</title>

      <style>

        * {
          box-sizing: border-box;
          margin: 0;
          padding: 0;
        }

        body {
          font-family: Arial, Helvetica, sans-serif;
          background: #0f172a;
          color: white;
          min-height: 100vh;

          display: flex;
          justify-content: center;
          align-items: center;

          padding: 30px;
        }

        .container {
          width: 100%;
          max-width: 900px;
          text-align: center;
        }

        .badge {
          display: inline-block;

          padding: 8px 18px;

          border-radius: 20px;

          background: #1e293b;

          color: #38bdf8;

          font-size: 14px;

          font-weight: bold;

          margin-bottom: 25px;
        }

        h1 {
          font-size: 48px;

          margin-bottom: 15px;
        }

        .highlight {
          color: #38bdf8;
        }

        .subtitle {
          color: #94a3b8;

          font-size: 18px;

          line-height: 1.6;

          margin-bottom: 30px;
        }

        .status {
          display: inline-block;

          padding: 12px 25px;

          border-radius: 8px;

          background: #052e16;

          border: 1px solid #22c55e;

          color: #4ade80;

          font-weight: bold;

          margin-bottom: 40px;
        }

        .grid {
          display: grid;

          grid-template-columns:
            repeat(auto-fit, minmax(200px, 1fr));

          gap: 20px;

          margin-bottom: 40px;
        }

        .card {
          background: #1e293b;

          border: 1px solid #334155;

          border-radius: 12px;

          padding: 25px;
        }

        .card h3 {
          color: #38bdf8;

          margin-bottom: 12px;
        }

        .card p {
          color: #94a3b8;

          line-height: 1.6;
        }

        .architecture {
          background: #020617;

          border: 1px solid #334155;

          border-radius: 12px;

          padding: 30px;

          margin-bottom: 35px;
        }

        .architecture h2 {
          margin-bottom: 25px;
        }

        .flow {
          color: #38bdf8;

          font-size: 18px;

          line-height: 2;
        }

        footer {
          color: #64748b;

          font-size: 14px;
        }

      </style>

    </head>


    <body>

      <div class="container">

        <div class="badge">
          AWS + TERRAFORM + DOCKER
        </div>


        <h1>
          Terraform
          <span class="highlight">DevOps</span>
          Project
        </h1>


        <p class="subtitle">

          Infrastructure provisioned with Terraform
          and an Nginx container deployed automatically
          on AWS EC2.

        </p>


        <div class="status">

          ● NGINX CONTAINER RUNNING

        </div>


        <div class="grid">

          <div class="card">

            <h3>Terraform</h3>

            <p>
              Infrastructure as Code used to
              provision and manage AWS resources.
            </p>

          </div>


          <div class="card">

            <h3>AWS VPC</h3>

            <p>
              Custom VPC with public subnet,
              Internet Gateway and route table.
            </p>

          </div>


          <div class="card">

            <h3>EC2</h3>

            <p>
              Ubuntu EC2 instance provisioned
              automatically using Terraform.
            </p>

          </div>


          <div class="card">

            <h3>Docker</h3>

            <p>
              Docker runs the Nginx Alpine
              container on port 80.
            </p>

          </div>

        </div>


        <div class="architecture">

          <h2>
            Deployment Architecture
          </h2>


          <div class="flow">

            Terraform
            <br>
            ↓
            <br>

            AWS VPC
            <br>
            ↓
            <br>

            Public Subnet
            <br>
            ↓
            <br>

            EC2
            <br>
            ↓
            <br>

            Docker
            <br>
            ↓
            <br>

            Nginx Container
            <br>
            ↓
            <br>

            Web Application

          </div>

        </div>


        <footer>

          Built with Terraform • AWS • Docker • Nginx

        </footer>

      </div>

    </body>

    </html>

    HTML


    # ==========================================
    # PULL NGINX IMAGE
    # ==========================================

    docker pull nginx:alpine


    # ==========================================
    # RUN NGINX CONTAINER
    # ==========================================

    docker run -d \
      --name nginx \
      -p 80:80 \
      -v /home/ubuntu/web:/usr/share/nginx/html:ro \
      nginx:alpine

  EOF


  # ==========================================
  # EC2 TAGS
  # ==========================================

  tags = {
    Name = var.instance_name
  }
}