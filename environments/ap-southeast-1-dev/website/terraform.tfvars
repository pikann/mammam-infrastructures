aws_region = "ap-southeast-1"
aws_access_key = ""
aws_secret_key = ""

environment_name                    = "dev"

# ECS
ecs_cluster_name                    = "mammam-backend"
# End ECS

# VPC
vpc_name                            = "mammam-vpc"
vpc_cidr_block                      = "10.0.0.0/16"
availability_zones                  = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
public_subnet_cidr_block            = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
# End VPC

# ECR
ecr_name = "mammam"
mutability = "MUTABLE"
scan_on_push = false
# End ECR

# AWS IAM ROLE
iam_role_name                 = "iam-mammam-role"
aws_iam_instance_profile_name = "iam-mammam-profile"
aws_iam_role_policy_name      = "mammam-policy"
# End AWS IAM ROLE

# AWS security group
security_group_name                   = "mammam-sg"
security_group_description            = "mammam security group tls"
security_group_http_cidr_blocks       = ["0.0.0.0/0"]
security_group_http_ipv6_cidr_blocks  = ["::/0"]
security_group_https_cidr_blocks      = ["0.0.0.0/0"]
security_group_https_ipv6_cidr_blocks = ["::/0"]
security_group_ssh_cidr_blocks        = ["0.0.0.0/0"]
# End AWS security group

# AWS Load balancing
alb_name                      = "mammam-alb"
lb_target_group               = "mammam-api-service"
# End AWS Load balancing

# ACM Certificate
domain_name                   = "api.mammam.online"
validation_method             = "DNS"
create_before_destroy         = true
# End ACM Certificate

# CloudWatch Log
cloudwatch_log_group_name                   = "mammam/backend-api-service"
# End CloudWatch Log

# ECS Service
ecs_service_private_namespace_name          = "mammam-private-namespace"
ecs_service_private_namespace_description   = "mammam private namespace "
ecs_service_name                            = "mammam-api-service"
container_name                              = "backend-api-container"
container_port                              = 80
task_family_name                            = "mammam"
# End ECS service

# S3
photo_video_bucket_name        = "mammam-bucket"
photo_video_bucket_acl         = "public-read"
# End S3

# ECR ML
ecr_ml_name = "mammam-ml"
# End ECR ML

# S3 admin
admin_bucket_name = "admin.mammam.online"
# End S3 admin

# EC2 instance socket
socket_instance_name = "socket-instance"
# End EC2 instance socket
