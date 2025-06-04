terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" 
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"] 

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "devops_instance_sg" {
  name        = "devops-instance-sg"
  description = "Permite acesso SSH e HTTP para a instancia EC2 do projeto DevOps"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-fase1-sg"
  }
}

resource "aws_instance" "devops_server" {
  ami           = data.aws_ami.amazon_linux_2.id 
  instance_type = "t2.micro"                     
  key_name      = "vockey"                    

  vpc_security_group_ids = [aws_security_group.devops_instance_sg.id]

  tags = {
    Name = "Servidor-DevOps-Fase1"
  }
}