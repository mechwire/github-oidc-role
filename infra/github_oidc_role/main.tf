terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48.0"
    }
  }
}

# Outline a Trust Policy and create a role with it
data "aws_iam_policy_document" "github" {
  statement {
    sid = "GitHubActionsOIDCAuth"

    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${var.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com",
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:${var.organization}/${var.repository_name}:*"
      ]
    }
  }
}

resource "aws_iam_role" "github" {
  name               = "github_infra_${var.repository_name}"
  assume_role_policy = data.aws_iam_policy_document.github.json

  tags = {
    github     = true,
    repository = var.repository_name,
  }
}
