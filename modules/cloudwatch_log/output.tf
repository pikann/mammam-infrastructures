output "name" {
  description = "The Cloudwatch Log Name"
  value       = aws_cloudwatch_log_group.mammam_cloudwatch_group.name
}
