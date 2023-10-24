resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.ecs-cluster

  tags = {
    Name = var.ecs-cluster
  }
}

resource "aws_ecs_task_definition" "service" {
  family                = "service"
  container_definitions = <<DEFINITION
  [
    {
      "name": "ecs-container",
      "image": "${var.docker-image}"
      "entryPoint": [],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.ecs-log-group.id}",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "portMappings": [
        {
          "containerPort": "${var.container-port}",
          "hostPort": "${var.host-port}"
        }
      ],
      "cpu": 256,
      "memory": 512,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn

  tags = {
    Name        = "service-td"
  }
}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.service.family
}

resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "ecs-service"
  cluster              = aws_ecs_cluster.ecs-cluster.id
  task_definition      = "${aws_ecs_task_definition.service.family}:${max(aws_ecs_task_definition.service.revision, data.aws_ecs_task_definition.main.revision)}"
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = var.desired-count
  force_new_deployment = true

  network_configuration {
    subnets          = data.aws_subnets.private-subnet.ids
    assign_public_ip = false
    security_groups = [
      aws_security_group.ecs-container-sg.id,
      data.aws_security_group.selected.id
    ]
  }

  load_balancer {
    target_group_arn = data.aws_alb_target_group.selected.arn
    container_name   = "ecs-container"
    container_port   = var.container-port
  }
}