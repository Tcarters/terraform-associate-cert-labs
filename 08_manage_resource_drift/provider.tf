
terraform {
  cloud {
    organization = "prod-tdmund-tf"

    workspaces {
      name = "lab08-resource-drift"
    }
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 3.24.1"
    }
  }
}