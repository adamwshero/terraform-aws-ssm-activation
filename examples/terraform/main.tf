module "ssm-activations" {
  source = "git@github.com:adamwshero/terraform-aws-ssm-activation.git//.?ref=1.0.0"

  create_iam_role = true
  iam_role_name   = "ssm-activation-test"
  ssm_activations = [
    {
      name            = "${local.product}-lightsail-${local.env}"
      description     = "Lightsail SSM Activation"
      expiration_date = "2024-10-31T23:59:59Z"
      registration_limit = 2
    },
    {
      name            = "${local.product}-ecs-${local.env}"
      description     = "ECS SSM Activation"
      expiration_date = "2024-10-31T23:59:59Z"
      registration_limit = 2
    }
  ]

  tags = {
    Environment        = local.env
    Owner              = "Platform Engineering"
    CreatedByTerraform = true
  }
}
