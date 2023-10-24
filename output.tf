output "vpc-id" {
    value = module.vpc.vpc-id
}

output "public-subnet-id" {
    value = module.vpc.public-subnet-id
}

output "domain" {
  value = module.alb.domain
}