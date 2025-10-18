

terraform {
  cloud {
    organization = "prod-tdmund-tf"
    workspaces {
      name = "lab12_secrets_vaults_tfe"
    }
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
    }

    vault = {
        source = "hashicorp/vault"
        version = "5.3.0"

    }
  }
}