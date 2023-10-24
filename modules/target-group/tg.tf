resource "aws_lb_target_group" "ip-example" {
  name        = var.tg-name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  deregistration_delay = 60
  vpc_id      = data.aws_vpc.selected.id
  health_check {
    path = var.tg-healthcheck-path
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 2
    interval = 10
  }
  tags = {
    Name = var.tg-name
  }
}