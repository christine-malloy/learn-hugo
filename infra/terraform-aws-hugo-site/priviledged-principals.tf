locals {
  # Must use derived values in order to validate `count` clauses
  privileged_principal_arns = var.privileged_principal_enabled == false ? [] : [
    {
      (aws_iam_role.deployment_iam_role[0].arn) = [""]
    },
  ]
  privileged_principal_actions = var.privileged_principal_actions
}

data "aws_iam_policy_document" "deployment_assume_role" {
  count = var.privileged_principal_enabled ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
      type        = "Federated"
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_org}/${var.github_repo}:*"]
    }
  }
}

data "aws_iam_policy_document" "deployment_iam_policy" {
  count = var.privileged_principal_enabled ? 1 : 0

  statement {
    actions   = local.privileged_principal_actions
    effect    = "Allow"
    resources = ["arn:aws:s3:::${module.this.id}*"]
  }
}

resource "aws_iam_policy" "deployment_iam_policy" {
  count = var.privileged_principal_enabled ? 1 : 0

  policy = join("", data.aws_iam_policy_document.deployment_iam_policy[*].json)
}

module "deployment_principal_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  enabled = var.privileged_principal_enabled

  attributes = ["deployment"]

  context = module.this.context
}

resource "aws_iam_role" "deployment_iam_role" {
  count = var.privileged_principal_enabled ? 1 : 0

  name               = join("", module.deployment_principal_label[*].id)
  assume_role_policy = join("", data.aws_iam_policy_document.deployment_assume_role[*].json)

  tags = module.deployment_principal_label.tags
}