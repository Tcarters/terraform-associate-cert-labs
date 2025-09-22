
terraform {
  cloud {
    organization = "prod-tdmund-tf"

     workspaces {
        name = "lab05-modules-use"
        }
  }

   required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49.0"
    }
  }
  required_version = ">= 1.1.0"
 
}