

output "instance_id" {
    value       = aws_instance.instance01.id
    description = "ID of instance"
}

output "public_ip" {
    value       = aws_instance.instance01.public_ip
    description = "The public IP of the web server"
}

output "security_groups" {
  value         = [aws_instance.instance01.vpc_security_group_ids]
}