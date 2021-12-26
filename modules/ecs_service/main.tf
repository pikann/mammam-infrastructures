resource "aws_ecs_task_definition" "mammam_ecs_task_definition" {
  family                   = "mammam-${var.environment_name}"
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
