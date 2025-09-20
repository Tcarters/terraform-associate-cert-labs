# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  cloud {
    organization = "prod-tdmund-tf"

    workspaces {
      name = "lab04-tf-troubleshooting"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.24.1"
    }
  }
  required_version = ">= 0.15.2"
}

provider "aws" {
  region = var.region
}