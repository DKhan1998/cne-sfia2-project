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
  default = "testdb"
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
  default = "default-vpc-0a5fd4ee148efd024"
}
variable "domain_iam_role_name" {
  default = "arn:aws:iam::260842022928:user/Terraform"
}
variable "vpc-security-group-ids" {
  default = [
  "sg-04f8bb95d7d87417f"]
}
variable "region" {
  default = "eu_west_2"
}
variable "final_snapshot_identifier" {
  default = false
}