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


#5e-ii-----------------------------

#5f-i------------------------------

#5f-ii-----------------------------
