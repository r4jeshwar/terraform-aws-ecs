variable "vpc-name" {
  description = "vpc name"
}

variable "vpc-cidr" {
  description = "vpc CIDR"
}

variable "public-subnet" {
  description = "public subnet"
}

variable "private-subnet" {
  description = "public subnet"
}

variable "igw-name" {
  description = "Internet gateways name"
}

variable "public-routes-igw-cidr" {
  description = "Internet gateways CIDR"
}

variable "public-route-name" {
  description = "Route table name"
}

variable "nat-gw-name" {
  description = "NAT gateway name"
}

variable "eip-name" {
  description = "NAT gateway name"
}

variable "private-routes-igw-cidr" {
  description = "NAT gateway name"
}

variable "private-route-name" {
  description = "Route table name"
}