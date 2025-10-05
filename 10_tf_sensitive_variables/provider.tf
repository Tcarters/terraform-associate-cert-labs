
terraform {
  
  cloud {
    organization = "prod-tdmund-tf"

    workspaces {
      name = "lab10_tf_sensitive_data"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
  }
}