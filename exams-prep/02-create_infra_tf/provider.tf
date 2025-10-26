
terraform {
  cloud {

    organization = "exam-hcta"

    workspaces {
      name = "02-create-infra-aws"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}