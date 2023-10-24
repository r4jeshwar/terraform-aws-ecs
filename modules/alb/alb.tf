resource "aws_lb" "alb" {
  name               = var.alb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.selected.id]
  subnets            = data.aws_subnets.selected.ids

  enable_deletion_protection = false

  tags = {
    Name        = var.alb-name
    Environment = "production"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


resource "aws_lb_listener" "https" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate-arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener_rule" "host_based_routing" {
  listener_arn = "${aws_lb_listener.https.arn}"
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = data.aws_lb_target_group.selected.arn
  }

  condition {
    host_header{
      values = [var.domain]
    }
  }
}