# Terragrunt Example w/optional IAM Role

```
terraform {
  source = "git@github.com:adamwshero/terraform-aws-ssm-activation.git//.?ref=1.0.0"
}

inputs = {
  create_iam_role = true
  iam_role_name   = "company-ssm-activation"
  ssm_activations = [
    {
      name            = "${local.app}-lightsail-${local.env}"
      description     = "Lightsail SSM Activation"
      expiration_date = "2024-10-31T23:59:59Z"
      registration_limit = 2
    },
    {
      name            = "${local.app}-ecs-${local.env}"
      description     = "ECS SSM Activation"
      expiration_date = "2024-10-31T23:59:59Z"
      registration_limit = 5
    }
  ]
  tags = {
    Environment        = local.env
    Owner              = "Platform Engineering"
    CreatedByTerraform = true
  }
}
```
## Terragrunt Example w/Existing IAM Role
```
terraform {
  source = "git@github.com:adamwshero/terraform-aws-ssm-activation.git//.?ref=1.0.0"
}

inputs = {
  create_iam_role = false
  ssm_activations = [
    {
      name            = "${local.app}-lightsail-${local.env}"
      description     = "Lightsail SSM Activation"
      expiration_date = "2024-10-31T23:59:59Z"
      iam_role        = "my-role-name"
      registration_limit = 2
    },
    {
      name            = "${local.app}-ecs-${local.env}"
      description     = "ECS SSM Activation"
      expiration_date = "2024-10-31T23:59:59Z"
      iam_role        = "my-role-name"
      registration_limit = 5
    }
  ]
  tags = {
    Environment        = local.env
    Owner              = "Platform Engineering"
    CreatedByTerraform = true
  }
}
```