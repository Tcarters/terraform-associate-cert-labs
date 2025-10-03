terraform {
  cloud {
    organization = "prod-tdmund-tf"
    workspaces {
      name = "lab10_tf_sensitive_data"
    }
  }
}