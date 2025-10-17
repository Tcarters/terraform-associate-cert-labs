
output "instance_ids" {  # Instance ID output
    description     = "IP address of Database instance"
    value           = aws_db_instance.database.address
}
