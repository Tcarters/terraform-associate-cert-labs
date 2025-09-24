

terraform {
  
  cloud {
    organization = "prod-tdmund-tf"

    workspaces {
      name = "lab06-modules-creation"
    }
  }

  required_providers {
    aws = {
        source  = "hashicorp/aws"
    }
  }
}