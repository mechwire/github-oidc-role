output "arn" {
  description = "The ARN for the role that was created"
  value       = aws_iam_role.github.arn
}
