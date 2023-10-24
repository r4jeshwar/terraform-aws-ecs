variable "vpc-name" {
  description = "vpc name"
}

variable "tg-name" {
  description = "target-group name"
}

# variable "tg-healthcheck-path" {
#   description = "target-group healthcheck path"
# }

variable "ecs-taskexecutionrole-name" {
  description = "ecsTaskExecutionRole name"
}

variable "ecs-cluster" {
  description = "ECS cluster name"
}

variable "ecs-log-group-name" {
  description = "Log group name"
}

variable "private-subnet-name" {
  description = "Name for private subnet"
}

variable "ecs-sg" {
  description = "security group for elb"
}

variable "container-sg" {
   description = "Security group for ECS service"
}

variable "docker-image" {
  description = "docker image to deploy in ECS"
}

variable "desired-count" {
  description = "desired count in loadbalancer"
}

variable "container-port" {
  description = "container port"
}

variable "host-port" {
  description = "host port"
}