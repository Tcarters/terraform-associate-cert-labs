terraform {

  cloud {
     organization = "prod-tdmund-tf"

     workspaces {
       name = "lab02-manage-tf-version"
     }
  }


  required_providers {
    aws = {
      version = "~> 6.13.0"
    }
    random = {
      version = "~> 3.6.2"
    }
  }

    required_version = "~> 1.10.0" # this is terraform version reauired to deploy resources

} 