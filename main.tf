terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 2.0.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region                   = "us-west-2"
  shared_credentials_files = ["/Users/matt/.aws/credentials"]
}


data "http" "my_ip" {
  url = "https://ipinfo.io/ip"
}

locals {
  my_ip_cidr = "${data.http.my_ip.body}/32"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0cf2b4e024cdb6960"
  instance_type = "t2.medium"
  key_name      = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.Minecraft_Server_SG.id]

  tags = {
    Name = var.instance_name
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLo2yjjQAeMlIVNslnwozfazCnfU6oh/2PsvsDAoZG/cdjRY78ZP0YxCscMUimfo9B9ZsCTt13p1acI9/3y+ClClZEzzPr0NULEjYcGpRJfP7szdmU3sG1NVOLESMQrG3XOdhWRV8kzF7d5Ho58SG2vQy7OuoGGcDEvZhL6eURYgZfqfiGkgVLolaz1ftRcrx3gq3TZ4J7ZB+59C9XVCVrkkriHUtmjM4byapHNP7ivKmVwGF4+dCJPwF4EhGKxnBOeKnzKqhz0bWaLcvYX3k5PffISxk5+bX3JPoIa6towuyikK5XZ25GL9zioUilNUR6q/CC+Pts8e7c/9r9trtN matt@Matthews-MacBook-Pro.local"
}

resource "aws_security_group" "Minecraft_Server_SG" {
  name = "minecraft-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_cidr]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_cidr]
  }
  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
