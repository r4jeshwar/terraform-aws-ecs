variable "ecs-sg" {
  description = "security group for elb"
}

variable "public-subnet" {
  description = "public subnet"
}

variable "alb-name" {
  description = "Name for Application loadbalancer"
}

variable "public-subnet-name" {
  description = "Name for Public subnet"
}

variable "certificate-arn" {
  description = "ARN certificate"
}

variable "tg-name" {
  description = "target-group name"
}

variable "domain" {
  type = string
  description = "domain"
}