resource "aws_security_group" "ecs-container-sg" {
  name        = var.container-sg
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups  = [data.aws_security_group.selected.id]
    #ipv6_cidr_blocks = [aws_vpc.vpc.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.container-sg
}

}