
terraform {
  cloud {
    organization = "prod-tdmund-tf"
    workspaces {
      name = "lab07-apply-tfe"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}