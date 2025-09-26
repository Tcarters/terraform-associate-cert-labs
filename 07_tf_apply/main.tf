provider "aws" {
  region = var.region
}

provider "random" {}

provider "time" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "random_pet" "instance" {
  length = 2
}

resource "aws_instance" "main" {
  count = 3

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name  = "${random_pet.instance.id}-${count.index}"
    Owner = "${var.project_name}"
  }
}

resource "aws_s3_bucket" "mybucket01" {
  tags = {
    Name  = "bucket-${var.env_name}-${var.region}"
    Owner = "${var.project_name}"
  }
}