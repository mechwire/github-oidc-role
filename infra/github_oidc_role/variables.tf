variable "aws_account_id" {
  type        = string
  description = "the account ID used in many ARNs."
  sensitive   = true
}

variable "organization" {
  description = "the name of the organization on GitHub (e.g., 'user' in user/project)"
  type        = string
}

variable "repository_name" {
  description = "the name of the repository on GitHub (e.g., 'project' in user/project)"
  type        = string
}
