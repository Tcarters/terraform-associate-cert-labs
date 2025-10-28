

output "first_tags" {
    description = "Instance tags"
    value       = aws_instance.ubuntu[0].tags
}

output "elb_dns" {
    description = "ELB dns"
    value       = aws_elb.elb01.dns_name

}

output "Ip_instance" {
    description = "Instance IP"
    value       = aws_instance.ubuntu[*].public_ip

}

output "private_addresses" {
    description = "Private DNS for AWS instances"
    value       =  aws_instance.ubuntu[*].private_dns
}