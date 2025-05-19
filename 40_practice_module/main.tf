#########################################
# AWS account Id
#########################################
data "aws_caller_identity" "current" {}
locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}

#########################################
# IAM policy
#########################################
module "s3_full_access_iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "S3-full-access"
  path        = "/"
  description = "S3-full-access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

##########################################
# IAM assumable role with custom policies
##########################################

module "iam_assumable_role_custom" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  create_role = true

  trusted_role_arns = [
    "arn:aws:iam::${local.aws_account_id}:root",
  ]

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  role_name_prefix  = "custom-"
  role_requires_mfa = false

  role_sts_externalid = "s3-full-access-role"

  custom_role_policy_arns = [
    module.s3_full_access_iam_policy.arn
  ]
  #  number_of_custom_role_policy_arns = 3
}
