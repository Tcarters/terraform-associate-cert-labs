
output "instance_name" {
  value = aws_instance.app_server.tags
}

output "instance_ips" {
  value = aws_instance.app_server.public_ip
}
