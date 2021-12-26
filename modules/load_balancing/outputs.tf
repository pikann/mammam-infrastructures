output "alb_arn" {
  description = "The ALB ARN"
  value       = aws_lb.mammam_lb.arn
}

output "aws_lb_target_group_arn" {
  description = "The ALB target group ARN"
  value       = aws_lb_target_group.mammam_lb_target_group.arn
}
