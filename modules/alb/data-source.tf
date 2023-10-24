data "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.ecs-sg}"]
  }
}

data "aws_subnets" "selected" {
  filter {
    name   = "tag:Name"
    values = var.public-subnet-name
  }
}

data "aws_lb_target_group" "selected" {
    name = "${var.tg-name}"
}