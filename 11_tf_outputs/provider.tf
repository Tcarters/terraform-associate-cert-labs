
terraform {
  cloud {
    organization = "prod-tdmund-tf"
    workspaces {
      name = "lab11-outputs-tfe"
    }
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}