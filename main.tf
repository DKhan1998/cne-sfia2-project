# Specify a provider
provider "aws" {
  version                 = "~> 2.0"
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform"
}
# Create a resource
resource "aws_instance" "jenkins" {
  ami           = "ami-09a1e275e350acf38"
  instance_type = "t2.micro"
}
# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

