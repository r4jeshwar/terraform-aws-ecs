resource "aws_cloudwatch_log_group" "ecs-log-group" {
  name = var.ecs-log-group-name

  tags = {
    Environment = "production"
    Application = "ECS"
  }
}