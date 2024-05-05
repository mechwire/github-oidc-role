variable "openid_thumbprints" {
  type        = list(string)
  description = "the signature for the certificate used for the IdP (in this case, GitHub). It's technically not needed because AWS and GitHub have already shared them, but Terraform requires it."
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
  description = "the name of the role created, that can be assumed via OIDC with GitHub"
  type        = string
}
