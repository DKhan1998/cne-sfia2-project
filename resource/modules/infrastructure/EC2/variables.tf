variable "ami-id" {
  default = "ami-09a1e275e350acf38"
}
variable "instance-count" {
  default = "3"
}
variable "instance-tags" {
  default = [
    "Jenkins",
    "Testing",
  "K8S_CLuster"]
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
variable "region" {
  description = "Allocate the region for the vm"
  default     = "eu-west-2"
}