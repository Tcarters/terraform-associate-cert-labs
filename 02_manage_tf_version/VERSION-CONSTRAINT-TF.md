

## Terraform version constraints


<custom-element data-json="%7B%22type%22%3A%22table-metadata%22%2C%22attributes%22%3A%7B%22title%22%3A%22Terraform%20Version%20Constraints%22%7D%7D" />

| Required Version | Meaning                                      | Considerations                                                                 |
|------------------|----------------------------------------------|-------------------------------------------------------------------------------|
| 1.7.5            | Only Terraform v1.7.5 exactly                | To upgrade Terraform, first edit the `required_version` setting              |
| >= 1.7.5         | Any Terraform v1.7.5 or greater               | Includes Terraform v2.0.0 and above                                           |
| ~> 1.7.5         | Any Terraform v1.7.x, but not v1.8 or later  | Patch version updates should be non-disruptive                               |
| >= 1.7.5, < 1.9.5| Terraform v1.7.5 or greater, but less than v1.9.5 | Avoids specific version updates                                               |


- As a best practice, consider using ~> style version constraints to pin your major and minor Terraform version. Doing so will allow you and your team to use patch version updates without updating your Terraform configuration. You can then plan when you want to upgrade your configuration to use a new version of Terraform, and carefully review the changes to ensure that your project still works as intended.

- For example, if you write Terraform configuration using Terraform 1.0.0, you would add required_version = "~> 1.0.0" to your terraform { } block. This will allow you and your team to use any Terraform 1.0.x, but you will need to update your configuration to use Terraform 1.1.0 or later.