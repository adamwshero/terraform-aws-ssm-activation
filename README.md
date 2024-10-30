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

Terraform module to create an Amazon SSM Hybrid Activation using an existing or new IAM role.

[Amazon Systems Manager (SSM) Hybrid Activations](https://aws.amazon.com/systems-manager/) To configure non-EC2 machines for use with AWS Systems Manager in a hybrid and multicloud environment, you create a hybrid activation. Non-EC2 machine types supported as managed nodes include the following:

  - Servers on your own premises (on-premises servers)
  - AWS IoT Greengrass core devices
  - AWS IoT and non-AWS edge devices
  - Virtual machines (VMs), including VMs in other cloud environments

When you run the [create-activation](https://docs.aws.amazon.com/cli/latest/reference/ssm/create-activation.html) command to start a hybrid activation process, you receive an activation code and ID in the command response. You then include the activation code and ID with the command to install SSM Agent on the machine, as described in step 3 of [Managing servers in hybrid and multicloud environments with Systems Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-hybrid-multicloud.html). This activation process applies to all non-EC2 machine types except AWS IoT Greengrass core devices. For information about configuring AWS IoT Greengrass core devices for Systems Manager, see [Managing edge devices with Systems Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-setting-up-edge-devices.html).

[Read more about SSM Hybrid Activations](https://docs.aws.amazon.com/systems-manager/latest/userguide/activations.html)
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