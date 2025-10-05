provider "aws" {
    region               = var.aws_region
}

data "aws_availability_zones" "available" {
  filter {
    name                = "opt-in-status"
    values              = ["opt-in-not-required"]
  }
}

resource "random_string" "lb_id" {
    length              = 3
    special             = false
}

resource "aws_db_subnet_group" "private" {
    subnet_ids          = module.vpc.private_subnets
}

resource "aws_db_instance" "database" {
    allocated_storage   = 5
    engine              = "mysql"
    instance_class      = "db.t3.micro"
    username            = var.username_db
    password            = var.password_db

    db_subnet_group_name = aws_db_subnet_group.private.name

    skip_final_snapshot = true
}
