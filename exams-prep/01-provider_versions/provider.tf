
terraform {
  cloud {
    organization = "exam-hcta"
    workspaces {
      name = "prep-01_provider_version"
    }
  }

  required_providers {
    
  }

  required_version = "~> 1.10"
}