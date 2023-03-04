# contains information of variables used in main.tf
# Variables on Terraform are a great way to pack your configuration with easily readable data. 
# When you declare variables in the root module of your configuration, you can set their values using CLI options 
# and environment variables. When you declare them in child modules, the calling module should pass values 
# in the module block.


# Variables for VPC resource

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "dio-app-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-west-2a"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Variables for key pair resource

variable "key_name" {
  description = "The name for the key pair. "
  type        = string
  default     = "dio-app-key"
}

variable "public_key" {
  description = "The public key material"
  type        = string
  default     = ""
}

variable "private_key_algorithm" {
  description = "Name of the algorithm to use when generating the private key. Currently-supported values are `RSA` and `ED25519`"
  type        = string
  default     = "RSA"
}

variable "private_key_rsa_bits" {
  description = "When algorithm is `RSA`, the size of the generated RSA key, in bits (default: `4096`)"
  type        = number
  default     = 4096
}