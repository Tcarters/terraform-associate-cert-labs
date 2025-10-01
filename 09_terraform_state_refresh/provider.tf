

terraform {
  cloud {
    organization = "prod-tdmund-tf"
    workspaces {
      name = "lab09-state-refresh"
    }
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.4.0"
    }
  }
}