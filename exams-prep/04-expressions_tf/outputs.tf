

output "tags" {
  description = "Instance tags"
  value       = aws_instance.ubuntu.tags
}

output "elb_dns" {
  description = "ELB dns"
  value       = aws_elb.elb01.dns_name

}

output "Ip_instance" {
  description = "Instance IP"
  value       = aws_instance.ubuntu.public_ip

}