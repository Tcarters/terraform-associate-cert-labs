

terraform {
  
  cloud {
    organization = "prod-tdmund-tf"

    workspaces {
      name = "lab06-modules-create"
    }
  }

  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "6.14.1"

    }
  }
}