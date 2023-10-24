module "vpc" {
  source    = "./modules/vpc"
  vpc-name  = var.vpc-name
  vpc-cidr  = var.vpc-cidr
  public-subnet = var.public-subnet
  private-subnet = var.private-subnet
  igw-name = var.igw-name
  public-route-name = var.public-route-name
  public-routes-igw-cidr = var.public-routes-igw-cidr
  nat-gw-name = var.nat-gw-name
  eip-name = var.eip-name
  private-routes-igw-cidr = var.private-routes-igw-cidr
  private-route-name = var.private-route-name
}

module "security_group" {
  depends_on = [module.vpc]
  source = "./modules/security-group"
  ecs-sg = var.ecs-sg
  vpc-name  = var.vpc-name
}

module "target_group" {
  depends_on = [module.security_group]
  source = "./modules/target-group"
  vpc-name  = var.vpc-name
  tg-name = var.tg-name
  tg-healthcheck-path = var.tg-healthcheck-path
}

module "alb" {
  depends_on = [module.security_group, module.target_group]
  source = "./modules/alb"
  ecs-sg = var.ecs-sg
  public-subnet = var.public-subnet
  alb-name = var.alb-name
  public-subnet-name = var.public-subnet-name
  certificate-arn = var.certificate-arn
  tg-name = var.tg-name
  domain = var.domain
}
module "ecs" {
  depends_on = [module.alb]
  source = "./modules/ecs"
  vpc-name  = var.vpc-name
  tg-name = var.tg-name
  ecs-taskexecutionrole-name = var.ecs-taskexecutionrole-name
  ecs-cluster = var.ecs-cluster
  ecs-log-group-name = var.ecs-log-group-name
  private-subnet-name = var.private-subnet-name
  ecs-sg = var.ecs-sg
  container-sg = var.container-sg
  docker-image = var.docker-image
  desired-count = var.desired-count
  container-port = var.container-port
  host-port = var.host-port
  
}