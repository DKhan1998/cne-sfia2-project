variable "ami-id" {
  description = "AMI ID of ubuntu 18.04LTS eu-west-2"
  default     = "ami-09a1e275e350acf38"
}

variable "instance-count" {
  description = "Number of instances to build"
  default = "2"
}

variable "instance-type" {
  description = "Free tier EC2 Instance type"
  default     = "t2.micro"
}

variable "pem-key" {
  description = "Associated Key to SSH into the EC2 Instance"
  default     = "AWS_EU_Key"
}

variable "vpc-security-group-ids" {
  description = "The VPC associated with the instances"
  default     = [
    "sg-04f8bb95d7d87417f",
    ]
}

variable "subnet-id" {
  description = "The subnet to launch instance in"
  default     = "subnet-0baae22c4516ea061"
}

variable "iam-instance-profile" {
  description = "The iam role that the instance will assosiate with"
  default     = "arn:aws:iam::260842022928:user/Terraform"
}