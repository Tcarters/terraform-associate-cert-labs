terraform {

  cloud {
     organization = "prod-tdmund-tf"

     workspaces {
       name = "lab01-manage-states-tfe"
     }
  }
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}

#provider "aws" {
  # Configurat
#}