provider "aws" {
  version                 = "~> 2.0"
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform"
}

module "EC2" {
  source = "./EC2"
  region = var.region
  ami-id = var.ami-id
}

# Redirect variables to the rds instance
module "RDS" {
  source = "./RDS"
}

