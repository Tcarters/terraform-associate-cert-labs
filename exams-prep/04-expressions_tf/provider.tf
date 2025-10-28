

terraform {
  cloud {
    organization = "exam-hcta"
    workspaces {
      name = "04-expression-aws-tf"
    }
  }
}