output "acm_certificate_arn" {
  description = "ARN of ACM certificate"
  value       = aws_acm_certificate.mammam_cert.arn
}