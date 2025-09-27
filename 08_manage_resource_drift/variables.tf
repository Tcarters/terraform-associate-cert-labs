
variable "ec2_instance_name" {
    description = "Name of Ec2 instance"
    type        = string
    default     = "example"
}


variable "region" {
    description = "Region to deploy resources"
    default     = "ap-south-1"
    type        = string
}