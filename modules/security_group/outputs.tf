output "id" {
  description = "List of IDs of security groups"
  value       = aws_security_group.mammam_backend_api_security_group.id
}

output "name" {
  description = "List of IDs of security groups"
  value       = aws_security_group.mammam_backend_api_security_group.name
}
