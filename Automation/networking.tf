# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = { 
    Name = "${var.environment_tag}-VPC" }
}


# Subnet
resource "aws_subnet" "public_subnet" {
  cidr_block = var.public_subnet
  vpc_id = aws_vpc.vpc.id
  #availability_zone = data.aws_availability_zones.available.names
  tags = {
    Name = "${var.environment_tag}-subnet"
  }
}


# Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment_tag}-internet-gateway" 
  }
}

# Routing tables and associations
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { 
    Name = "${var.environment_tag}-rtb" 
  }
}

resource "aws_route_table_association" "rtb" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rtb.id
}