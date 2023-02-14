terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "app" {
  count                  = 3
  ami                    = "ami-830c94e3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0b7201237697afaa4"]
  subnet_id              = "subnet-0db4d98abc8eb6a2a"

  tags = {
    Name = "app${count.index}"
  }
}
