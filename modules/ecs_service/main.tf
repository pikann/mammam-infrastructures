resource "aws_ecs_task_definition" "mammam_ecs_task_definition" {
  family                   = "${var.task_family_name}-${var.environment_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu         = 256
  memory      = 512
  execution_role_arn       = "${var.iam_role_arn}"

  container_definitions = jsonencode([{
    name        = "${var.container_name}-${var.environment_name}"
    image       = "${var.repository_url}:latest"
    essential   = true
    portMappings = [{
      protocol      = "tcp"
      containerPort = 80
      hostPort      = 80
    }]
    logConfiguration: {
      logDriver: "awslogs",
      options: {
        "awslogs-group": "${var.cloudwatch_log_group_name}",
        "awslogs-region": "${var.aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }])
}

resource "aws_ecs_service" "mammam" {
  name            = "${var.ecs_service_name}-${var.environment_name}"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.mammam_ecs_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 50

  load_balancer {
    target_group_arn = var.aws_lb_target_group_arn
    container_name   = "${var.container_name}-${var.environment_name}"
    container_port   = var.container_port
  }

  network_configuration {
    assign_public_ip = true
    security_groups = var.security_group_ids
    subnets = var.subnet_ids
  }
}

resource "aws_appautoscaling_target" "scaling_target" {
  max_capacity = 3
  min_capacity = 1
  resource_id = "service/${var.ecs_cluster_name}-${var.environment_name}/${aws_ecs_service.mammam.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "scaling_memory" {
  name               = "${var.ecs_service_name}-memory-${var.environment_name}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.scaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "scaling_cpu" {
  name = "${var.ecs_service_name}-cpu-${var.environment_name}"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scaling_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.scaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}