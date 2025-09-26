variable "region" {
    type = string
    description = "Name of the region for all the resources"

    default = "ap-south-1" 
}

variable "project_name" {
    type = string
    description = "Name of the project."

    default = "lab07"
  
}

variable "env_name" {
    type = string
    description = "IT environment for deployment"

    default = "ete"
  
}