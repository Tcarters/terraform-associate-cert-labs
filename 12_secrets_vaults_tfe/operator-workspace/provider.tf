

terraform {
  cloud {
    organization = "prod-tdmund-tf"
    workspaces {
      name = "lab12_operator-space"
    }
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
    }

    vault = {
        source = "hashicorp/vault"
    }
  }
}