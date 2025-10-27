
variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default     = "10.1.0.0/24"
}

variable "environment_tag" {
  description = "Environment tag"
  default     = "marketing"
}

variable "aws_region" {
  description = "The AWS region to deploy your instance"
  default     = "ap-south-1"
}

variable "user_name" {
  description = "The user creating this infrastructure"
  default     = "terraform"
}

variable "user_department" {
  description = "The organization the user belongs to: dev, prod, qa"
  default     = "dev"
}

variable "aws_amis" {
  type = map(any)
  default = {
    "us-east-1" = "ami-04b70fa74e45c3917"
    "us-west-2" = "ami-08012c0a9ee8e21c4"
    "us-east-2" = "ami-09040d770ffe2224f"
  }
}
