[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

![Terraform](https://cloudarmy.io/tldr/images/tf_aws.jpg)
<br>
<br>
<br>
<br>
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/adamwshero/terraform-aws-ssm-activations?color=lightgreen&label=latest%20tag%3A&style=for-the-badge)
<br>
<br>
# terraform-aws-ssm-activations

Terraform module to create an Amazon SSM Activation with an optional IAM role.

[Amazon Systems Manager (SSM)](https://aws.amazon.com/systems-manager/) makes it easy for you to create and manage cryptographic keys and control their use across a wide range of AWS services and in your applications. AWS KMS is a secure and resilient service that uses hardware security modules that have been validated under FIPS 140-2, or are in the process of being validated, to protect your keys. AWS KMS is integrated with AWS CloudTrail to provide you with logs of all key usage to help meet your regulatory and compliance needs.
<br>

## Module Capabilities
- Create one or many SSM Activations.
- (Optional) Create an IAM role for the SSM Activation(s).
<br>

## Examples
Look at our complete [Terraform examples](latest/examples/terraform/) where you can get a better context of usage for various scenarios. The Terragrunt example can be viewed directly from GitHub.
<br>

## Special Notes
  * (IAM Role)
    * If you want to use an existing IAM role for the SSM Activations, you can specify a name of an IAM role, not the arn. The name cannot exceed 64 characters and must already have an `ssm` trust policy associated with it.
<br>

## Usage

### Terraform Example with optional IAM role.
```
module "ssm-activations" {
  source = "git@github.com:adamwshero/terraform-aws-ssm-activation.git//.?ref=1.0.0"
 
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

### Terragrunt Example with optional IAM role.

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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30.0 |
| <a name="requirement_terragrunt"></a> [terragrunt](#requirement\_terragrunt) | >= 0.28.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.30.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_ssm_activation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_activation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Whether to create a new IAM role for SSM activations. | `bool` | `false` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | (Optional) Name of the IAM role to be created. | `string` | `""` | no |
| <a name="input_ssm_activations"></a> [ssm\_activations](#input\_ssm\_activations) | List of SSM activation configurations. | <pre>list(object({<br/>    name               = string<br/>    description        = optional(string)<br/>    expiration_date    = optional(string)<br/>    iam_role           = optional(string)<br/>    registration_limit = optional(number)<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the object. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ssm_activations"></a> [ssm\_activations](#output\_ssm\_activations) | List of SSM activations that have been created. |
<!-- END_TF_DOCS -->