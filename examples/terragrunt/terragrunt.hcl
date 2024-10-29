locals {
  env_vars     = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  common_vars  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  product_vars = read_terragrunt_config(find_in_parent_folders("product.hcl"))
  product      = local.product_vars.locals.product_name
  env          = local.env_vars.locals.env
  tags = merge(
    local.env_vars.locals.tags,
    local.additional_tags
  )
  additional_tags = {
  }
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:adamwshero/terraform-aws-ssm-activation.git//.?ref=1.0.0"
}

inputs = {
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
  tags = local.tags
}
