# Specify a provider
provider "aws" {
  version                 = "~> 2.0"
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform"
}

# Create a resource
resource "aws_instance" "EC2" {
  ami                    = var.ami-id
  count                  = var.instance-count
  instance_type          = var.instance-type
  vpc_security_group_ids = var.vpc-security-group-ids
  key_name               = var.pem-key
  subnet_id              = var.subnet-id
}

