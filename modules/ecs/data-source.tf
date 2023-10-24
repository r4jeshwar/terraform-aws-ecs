data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc-name}"]
  }
}

data "aws_subnets" "private-subnet" {
  filter {
    name   = "tag:Name"
    values = var.private-subnet-name
  }
}

data "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.ecs-sg}"]
  }
}

data "aws_alb_target_group" "selected" {
  name = var.tg-name
}