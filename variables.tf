variable "vpc-name" {
  description = "vpc name"
  default = "ECS-vpc"
}

variable "vpc-cidr" {
  description = "vpc CIDR"
  default = "10.0.0.0/16"
}

variable "public-subnet" {
  description = "vpc CIDR"
  default = [{ name = "ECS-public-subnet1", ipsec = "10.0.1.0/24", az = "us-east-1a" }, { name = "ECS-public-subnet2", ipsec = "10.0.2.0/24", az = "us-east-1b" }, { name = "ECS-public-subnet3", ipsec = "10.0.3.0/24", az = "us-east-1c" }]
}

variable "public-subnet-name" {
  description = "Load balancer name"
  default = ["ECS-public-subnet1", "ECS-public-subnet2", "ECS-public-subnet3"]
}

variable "private-subnet" {
  description = "vpc CIDR"
  default = [{ name = "ECS-private-subnet1", ipsec = "10.0.4.0/24" }, { name = "ECS-private-subnet2", ipsec = "10.0.5.0/24" }, { name = "ECS-private-subnet3", ipsec = "10.0.6.0/24" }]
}

variable "private-subnet-name" {
  description = "Load balancer name"
  default = ["ECS-private-subnet1", "ECS-private-subnet2", "ECS-private-subnet3"]
}

variable "igw-name" {
  description = "vpc name"
  default = "ECS-igw"
}

variable "public-routes-igw-cidr" {
  description = "vpc name"
  default = "0.0.0.0/0"
}

variable "public-route-name" {
  description = "Route table name"
  default = "ECS-route"
}

variable "nat-gw-name" {
  description = "Route table name"
  default = "ECS-nat-gw"
}

variable "eip-name" {
  description = "NAT gateway name"
  default = "ECS-eip"
}

variable "private-routes-igw-cidr" {
  description = "vpc name"
  default = "0.0.0.0/0"
}

variable "private-route-name" {
  description = "Route table name"
  default = "ECS-private-route"
}

variable "ecs-sg" {
  description = "security group for elb"
  default = "ECS-sg"
}

variable "tg-name" {
  description = "target-group name"
  default = "ECS-tg"
}

variable "alb-name" {
  description = "Name for Application loadbalancer"
  default = "ECS-alb"
}

variable "ecr-name" {
  description = "ecr repository name"
  default = "ecs-ecr"
}

variable "ecs-taskexecutionrole-name" {
  description = "ecsTaskExecutionRole name"
  default = "ECSTaskExecutionRole-name"
}

variable "ecs-cluster" {
  description = "ECS cluster name"
  default = "ECS-cluster"
}

variable "ecs-log-group-name" {
  description = "Log group name"
  default = "ECS-log"
}

variable "container-sg" {
   description = "Security group for ECS service"
   default = "ECS-service-sg"
}

variable "tg-healthcheck-path" {
  description = "target-group healthcheck path"
  default = ""
}

variable "certificate-arn" {
  description = "ARN certificate"
  default = ""
}

variable "domain" {
  type = string
  description = "domain"
  default = ""
}

variable "access-key" {
  description = "AWS Access key"
  default = ""
}

variable "secret-key" {
  description = "AWS secret key"
  default = ""
}

variable "docker-image" {
  description = "docker image to deploy in ECS"
  default = ""
}

variable "desired-count" {
  description = "desired count in loadbalancer"
  default = ""
}

variable "container-port" {
  description = "container port"
  default = ""
}

variable "host-port" {
  description = "host port"
  default = ""
}