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
    sid = "1"

    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = [var.openid_provider_arn]
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
        "repo:${var.organization}/${var.repository}:*"
      ]
    }
  }
}

resource "aws_iam_role" "github" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.github.json
}
