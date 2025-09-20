
/** Data Sources configurations **/
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

///**** Main compute instances **///

# Generate a new SSH key pair
resource "tls_private_key" "web_app_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Register the public key with AWS
resource "aws_key_pair" "web_app_key" {
  key_name   = "${var.name}-key-${md5(timestamp())}"  # Unique name with timestamp
  public_key = tls_private_key.web_app_key.public_key_openssh
}

# First create the directory
resource "null_resource" "create_ssh_dir" {
  provisioner "local-exec" {
    command = "mkdir -p ${path.root}/ssh-data"
  }
}

# Then save the key (depends on directory creation)
resource "local_file" "private_key" {
  depends_on = [null_resource.create_ssh_dir]  # Wait for directory

  filename        = "${path.root}/ssh-data/${var.name}-key.pem"
  content         = tls_private_key.web_app_key.private_key_pem
  file_permission = "0600"
}


# Your EC2 instance resource
resource "aws_instance" "web_app" {
  for_each               = local.security_groups
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [each.value]
  key_name               = aws_key_pair.web_app_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              echo "Hello World" > /var/www/html/index.html
              systemctl restart apache2
              EOF

  tags = {
    Name = "${var.name}-tst-${each.key}"
  }
}

/**** Security groups ****/
resource "aws_security_group" "sg_ping" {
  name = "Allow Ping"
}

resource "aws_security_group" "sg_8080" {
  name = "Allow 8080"
  // connectivity to ubuntu mirrors is required to run `apt-get update` and `apt-get install apache2`
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_22" {
  name = "Allow 22"
}


/*** Security groups Rules ****/

// Added security rules for each sg
resource "aws_security_group_rule" "allow_ping" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  security_group_id        = aws_security_group.sg_ping.id
  source_security_group_id = aws_security_group.sg_8080.id
}

resource "aws_security_group_rule" "allow_8080" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_8080.id
  source_security_group_id = aws_security_group.sg_ping.id
}

resource "aws_security_group_rule" "allow_localhost_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  security_group_id        = aws_security_group.sg_8080.id
}

resource "aws_security_group_rule" "allow_localhost_ping" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  security_group_id        = aws_security_group.sg_ping.id
}

resource "aws_security_group_rule" "allow_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  security_group_id        = aws_security_group.sg_22.id
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"  # All protocols
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.sg_22.id
}
