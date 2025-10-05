
output "instance_ids" {
    description     = "IP address of Database instance"
    value           = aws_db_instance.database.address
}