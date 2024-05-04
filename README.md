# github-oidc-role


This creates an AWS role that can be assumed during a GitHub Actions flow. It's meant to be more secure, as short-lived credentials are issued.

This is reusable, and meant to be called as a module by something else.


Quirks:
* GitHub and AWS have shared the OpenID thumbprints ahead of time. However, the TF resource to create the OIDC Provider requires it.



# Resources:
* [AWS](https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/)
* [GitHub](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)