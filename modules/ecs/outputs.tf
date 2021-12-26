output "ecs_cluster_id" {
  description = "The ECS Cluster id"
  value       = aws_ecs_cluster.mammam_ecs.id
}