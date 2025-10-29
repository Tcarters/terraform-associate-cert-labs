

terraform {
  cloud {
    organization = "exam-hcta"
    workspaces {
      name = "05-dependencies"
    }
  }

  #   required_providers {
  #     aws = 
  #   }
}