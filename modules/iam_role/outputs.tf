output "iam_role_arn" {
  description = "The IAM role ARN"
  value       = aws_iam_role.mammam_role.arn
}