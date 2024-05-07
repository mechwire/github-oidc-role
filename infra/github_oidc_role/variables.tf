variable "openid_provider_arn" {
  type        = string
  description = "the ARN of the OpenID provider (in this case, GitHub)."
  sensitive   = true
}

variable "organization" {
  description = "the name of the organization on GitHub (e.g., 'user' in user/project)"
  type        = string
}

variable "repository" {
  description = "the name of the repository on GitHub (e.g., 'project' in user/project)"
  type        = string
}

variable "role_name" {
  description = "the name of the role to be created, that can be assumed via OIDC with GitHub"
  type        = string
}
