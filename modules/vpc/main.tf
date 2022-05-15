#5a--------------------------------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "GV VPC"
  }
}

resource "aws_subnet" "public1" {
  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.101.0/24"

  tags = {
    Name = "GV subnet public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.102.0/24"

  tags = {
    Name = "GV subnet public2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "GV subnet private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "GV subnet private2"
  }
}
#5b--------------------------------
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "GV IGW"
  }
}

#5c--------------------------------
resource "aws_eip" "nat_ip" {
  vpc = true

  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "GV NAT Elastic IP"
  }
}

#5d--------------------------------
resource "aws_nat_gateway" "nat_public" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public1.id

  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "GV NAT public gw"
  }
}

#5e-i------------------------------
resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "GV route table public"
  }
}

resource "aws_route_table_association" "rta_public" {
  subnet_id = aws_subnet.public1.id
  route_table_id = aws_route_table.rt-public.id
}

#5e-ii-----------------------------
resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_public.id
  }

  tags = {
    Name = "GV route table private"
  }
}

resource "aws_route_table_association" "rta_private" {
  subnet_id = aws_subnet.private1.id
  route_table_id = aws_route_table.rt-private.id
}

#5f-i&ii---------------------------
resource "aws_security_group" "inbound" {
  name        = "inbound-traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["212.93.112.80/32"]
  }

  tags = {
    Name = "GV allow_inbound"
  }
}
