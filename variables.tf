######################
# SSM Activation Vars
######################
variable "ssm_activations" {
  type = list(object({
    name               = string
    description        = optional(string)
    expiration_date    = optional(string)
    iam_role           = optional(string)
    registration_limit = optional(number)
  }))
  description = "List of SSM activation configurations."
}

variable "create_iam_role" {
  description = "Whether to create a new IAM role for SSM activations."
  type        = bool
  default     = false
}

variable "iam_role_name" {
  type        = string
  default     = ""
  description = "(Optional) Name of the IAM role to be created."
}

variable "tags" {
  type        = map(any)
  default     = null
  description = "(Optional) A map of tags to assign to the object."
}

# variable name 
# description = "(Optional) The default name of the registered managed instance."

# variable description
# description = "(Optional) The description of the resource that you want to register."

# variable expiration_date
# description = "(Optional) UTC timestamp in RFC3339 format by which this activation request should expire. The default value is 24 hours from resource creation time. Terraform will only perform drift detection of its value when present in a configuration."

# variable iam_role
# description = "(Required) The IAM Role to attach to the managed instance." (NOTE: Cannot exceed 64 chars. Expects the role name, not the arn.)

# variable registration_limit
# description = "(Optional) The maximum number of managed instances you want to register. The default value is 1 instance."
