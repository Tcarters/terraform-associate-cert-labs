

terraform {
  cloud {
    organization = "exam-hcta"
    workspaces {
      name = "03-functions-tf"
    }
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}