variable "github_openid_thumbprint" {
  type        = string
  description = "the signature for the certificate used for the IdP (in this case, GitHub). It's technically not needed because AWS and GitHub have already shared them, but Terraform requires it."
  sensitive   = true
}

variable "organization" {
  description = "the name of the organization on GitHub (e.g., 'user' in user/project)"
  type        = string
  default     = "mechwire"
}
