resource "aws_ssm_activation" "this" {
  for_each = {
    for key in var.ssm_activations : key.name => {
      name               = key.name
      description        = key.description
      expiration_date    = key.expiration_date
      iam_role           = key.iam_role != null ? key.iam_role : (var.create_iam_role ? aws_iam_role.this[0].name : null)
      registration_limit = key.registration_limit
    }
  }
  name               = each.value.name
  description        = each.value.description
  expiration_date    = each.value.expiration_date
  iam_role           = each.value.iam_role
  registration_limit = each.value.registration_limit
  tags               = var.tags
}

resource "aws_iam_role" "this" {
  count = var.create_iam_role ? 1 : 0

  name = var.iam_role_name

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": {"Service": "ssm.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  }
EOF
}