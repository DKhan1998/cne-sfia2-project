variable "ami-id" {
  default = "ami-09a1e275e350acf38"
}
variable "instance-count" {
  default = "2"
}
variable "instance-tags" {
  default = [
    "Jenkins",
  "Testing"]
}
variable "instance-type" {
  default = "t2.micro"
}
variable "pem-key" {
  default = "AWS_EU_Key.pem"
}
variable "public_key" {
  default = "~/.ssh/id_rsa.pub"
}
variable "vpc-security-group-ids" {
  default = [
  "sg-04f8bb95d7d87417f"]
}
variable "subnet-id" {
  description = "Specifies the subnet id"
  default     = "subnet-0baae22c4516ea061"
}
variable "iam-instance-profile" {
  description = "Describes the iam profile"
  default     = "arn:aws:iam::260842022928:user/Terraform"
}
variable "region" {
  description = "Allocate the region for the vm"
  default     = "eu-west-2"
}

# RDS Variables
variable "allocated_storage" {
  default = 20
}
variable "storage_type" {
  default = "gp2"
}
variable "engine" {
  default = "mysql"
}
variable "engine_version" {
  default = "5.7"
}
variable "instance_class" {
  default = "db.t2.micro"
}
variable "name" {
  default = "test-db"
}
variable "username" {
  default = "admin"
}
variable "password" {
  default = "password"
}
variable "parameter_group_name" {
  default = "default.mysql5.7"
}
variable "db_subnet_group_name" {
  default = "subnet-0baae22c4516ea061"
}
variable "domain_iam_role_name" {
  default = "arn:aws:iam::260842022928:user/Terraform"
}