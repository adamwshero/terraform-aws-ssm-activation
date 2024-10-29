output "ssm_activations" {
  description = "List of SSM activations that have been created."
  value = tomap({
    for k, ssm_activations in aws_ssm_activation.this : k => {
      ssm_activation_id                 = ssm_activations.id
      ssm_activation_name               = ssm_activations.name
      ssm_activation_code               = ssm_activations.activation_code
      ssm_activation_expired            = ssm_activations.expired
      ssm_activation_expiration_date    = ssm_activations.expiration_date
      ssm_activation_iam_role           = ssm_activations.iam_role
      ssm_activation_registration_limit = ssm_activations.registration_limit
      ssm_activation_registration_count = ssm_activations.registration_count
    }
  })
}
