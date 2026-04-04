#create a VPC
resource "aws_vpc" "red_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "red_vpc"
  }
}

#create a subnet1
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.red_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet1"
  }
}

#create a subnet2
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.red_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "subnet2"
  }
}

#internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.red_vpc.id

  tags = {
    Name = "gw"
  }
}

resource "aws_route_table" "route_table_ec2v1" {
  vpc_id = aws_vpc.red_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route_table_ec2v1"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table_ec2v1.id
}

resource "aws_route_table" "route_table_ec2v2" {
  vpc_id = aws_vpc.red_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route_table_ec2v2"
  }
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table_ec2v2.id
}