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

/*
Configures a Virtual Private Cloud (VPC) module, which provisions networking resources
such as a VPC, subnets, and internet and NAT gateways based on the arguments provided.
Uses the definitions in the file "variables.tf".
*/
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

# defines a key pair that will be assigned to the EC2 instances

module "key-pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "2.0.2"

  name = var.key_name
  
}

#  defines three EC2 instances provisioned within the VPC created by the module.

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  count = 3
  name  = "dio-app-ec2-cluster-${count.index}"

  ami                    = "ami-0c5204531f799e0c6"
  instance_type          = "t2.micro"
  key_name                = "user1"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

------------------
resource "aws_instance" "app" {
  count                  = 3
  ami                    = "ami-830c94e3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0b7201237697afaa4"]
  subnet_id              = "subnet-0db4d98abc8eb6a2a"
  associate_public_ip_address = true
  key_name = "TF_key"

  tags = {
    Name = "app${count.index}"
  }
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "TF_key" {
  key_name = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "TF_key" {
  content = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}