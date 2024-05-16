# github-oidc-role

This creates an AWS role that can be assumed during a GitHub Actions flow.

It's meant to be more secure, as short-lived credentials are issued.

This is reusable, and meant to be called as a module by something else.


## Why?

* Terraform / Tofu practice
* AWS Practice
* A specific use case

I was interested in seeing if I could create a GitHub Action role that could create other roles, so that a new role could be created for every repo, which would have more specific permissions scoped only to objects they create.

I'm not sure how secure it is, however, it was a good exercise and convenient.

### Scoping Permissions

Dynamic role access restrictions seem possible due to:

* [Required tags][AWS Required Tags] allow you to require that created resources have a specific tag
* [ABAC][AWS ABAC] requires that the resource (the thing being accessed) and the principal (the person doing the accessing) share the same tag

As long as the tag is not used on things they shouldn't access, they are correctly restricted.

## Quirks
* GitHub and AWS have shared the OpenID thumbprints ahead of time. However, the TF resource to create the OIDC Provider requires it.
    * I got the thumbprint by configuring the OIDC provider in the UI, as outlined in [AWS's article on the GitHub Actions OIDC integration with AWS]. It's not "correct" but was the easiest way.
* ABAC is not universally supported across resources


# Execution

1. You need to already have an AWS role to run the tf code.
2. Execute `infra/openid_provider`
3. Execute `infra`

## Validating Outcomes

You should have
* a new Identity Provider under `IAM > Identity providers`
* a new role under `IAM > Roles`


# Resources
* [AWS's article on the GitHub Actions OIDC integration with AWS]
* [GitHub's article on the GitHub Actions OIDC integration with AWS](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
* [AWS ABAC]
* [AWS Required Tags]
* [AWS docs - "Grant permission to tag resources during creation"]

<!-- Links -->
[AWS's article on the GitHub Actions OIDC integration with AWS]: https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/
[AWS ABAC]: https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html
[AWS Required Tags]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_iam-new-user-tag.html
[AWS docs - "Grant permission to tag resources during creation"]: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/supported-iam-actions-tagging.html




