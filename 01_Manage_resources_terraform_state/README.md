# Learn Terraform State Management

- This first lab is a inspired from the [Learn Terraform State Management](https://developer.hashicorp.com/terraform/tutorials/state/state-cli) tutorial.

- It contains Terraform configuration you can use to learn how to create an AWS instance and security group, examine a state file, and then manipulate resources to observe how vital state is to your Terraform operations.


### Steps to deploy
1. Pre-requisites setup
    - The Terraform CLI 1.7+ installed locally
    - An AWS account
    - The AWS CLI installed
    - Your AWS credentials configured locally with your access keys and a default region.

2. Create an HPC account and login to HPC using terraform cli (optional)

3. Create resources 


### Exploring State move

1. In folder new_state, we modified the main file in the section:

```tf

data "terraform_remote_state" "root" {
  backend = "remote"

  #config = {
  #  path = "../terraform.tfstate"
  #}
  config = {
    organization = "prod-tdmund-tf"
    workspaces = {
      name = "lab01-manage-states-tfe" # the workspace where main resources are deployed 
      }
      }
}
```

2. Move an instance resource from the folder ```new_state``` to main ```01_Manage_resources_terraform_state```

```sh
terraform state mv -state-out=../terraform.tfstate aws_instance.example_new aws_instance.example_new

terraform state mv -state-out ../../../01_Manage_resources_terraform_state/.terraform/terraform.tfstate aws_instance.example_new aws_instance.webserver01_new


### OUTPUT: Move "aws_instance.example_new" to "aws_instance.webserver01_new"
```