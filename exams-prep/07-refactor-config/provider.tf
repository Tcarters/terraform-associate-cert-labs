
terraform {
  cloud {
    organization = "exam-hcta"
    workspaces {
      name = "07-refactor-config"
    }
  }
}