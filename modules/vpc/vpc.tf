resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc-name
  }
}

resource "aws_subnet" "public_subnet" {
  count      = length(var.public-subnet)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public-subnet[count.index].ipsec
  availability_zone  = var.public-subnet[count.index].az
  map_public_ip_on_launch = "true"

  tags = {
    Name = var.public-subnet[count.index].name
  }
}

resource "aws_subnet" "private_subnet" {
  count      = length(var.private-subnet)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private-subnet[count.index].ipsec
  map_public_ip_on_launch = "true"

  tags = {
    Name = var.private-subnet[count.index].name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw-name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.public-routes-igw-cidr
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.public-route-name
  }
}

resource "aws_route_table_association" "rta" {
  count          = length(var.public-subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "ecs-eip" {
  tags = {
    Name = var.eip-name

  }
}   

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.ecs-eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = var.nat-gw-name
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.private-routes-igw-cidr
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = var.private-route-name
  }
}

resource "aws_route_table_association" "private-rta" {
  count          = length(var.private-subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private-route-table.id
}