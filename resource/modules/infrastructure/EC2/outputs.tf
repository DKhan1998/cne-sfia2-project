output "private_key" {
  value = aws_instance.EC2.*.key_name
}