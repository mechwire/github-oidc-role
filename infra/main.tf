# Make an OpenID Provider for GitHub

# Create a role for that provider which allows it to create other roles

terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48.0"
    }
  }
}


# Create the OIDC Provider Object
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [var.github_openid_thumbprint]
}


# Create a role that is accessible via the GitHub IDP
module "github_oidc_role" {
  source              = "./github_oidc_role"
  role_name           = "github_infra_role_provisioner"
  openid_provider_arn = aws_iam_openid_connect_provider.github.arn
  organization        = var.organization
  repository          = "*"
}

// This role can create other roles, but the created roles must have a repository tag
data "aws_iam_policy_document" "role_creation" {
  statement {
    effect    = "Allow"
    actions   = ["iam:CreateRole", "iam:TagRole"]
    resources = ["*"]
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws.TagKeys"
      values = [
        "github",
        "repository",
      ]
    }
  }
}

resource "aws_iam_policy" "role_creation" {
  name        = "github-role-creation"
  description = "This gives the ability to create roles with the proper tags."
  policy      = data.aws_iam_policy_document.role_creation.json
}

resource "aws_iam_role_policy_attachment" "role_creation" {
  role       = module.github_oidc_role.name
  policy_arn = aws_iam_policy.role_creation.arn
}

