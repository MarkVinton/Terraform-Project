resource "aws_vpc" "Project_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "Terraform Project"
  }
}

resource "aws_subnet" "Project_public_subnets" {
    count = length(var.availability_zones)
  vpc_id = aws_vpc.Project_vpc.id
cidr_block = var.public_subnets_cidr[count.index]
availability_zone = var.availability_zones[count.index]
tags = {
  Name = "Public Subnet ${count.index}"
}
}
resource "aws_subnet" "Project_private_subnets" {
    count = length(var.availability_zones)
  vpc_id = aws_vpc.Project_vpc.id
cidr_block = var.private_subnets_cidr[count.index]
availability_zone = var.availability_zones[count.index]
map_public_ip_on_launch = true
tags = {
  Name = "Private Subnet ${count.index}"
}
}
resource "aws_internet_gateway" "Project_igw" {
  vpc_id = aws_vpc.Project_vpc.id
}
resource "aws_route_table" "Public" {
  vpc_id = aws_vpc.Project_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Project_igw.id
  }
  tags = {
    Name = "Public Route"
  }
}
resource "aws_route_table" "Private" {
  vpc_id = aws_vpc.Project_vpc.id
  tags = {
    Name = "Private Route"
  }
}
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets_cidr)
  subnet_id = aws_subnet.Project_public_subnets[count.index].id
  route_table_id = aws_route_table.Public.id
}
resource "aws_route_table_association" "private" {
  count = length(var.private_subnets_cidr)
  subnet_id = aws_subnet.Project_private_subnets[count.index].id
  route_table_id = aws_route_table.Private.id
}
resource "aws_eip" "Project_eip" {
  count = length(var.public_subnets_cidr)
}
resource "aws_nat_gateway" "Project_ngw" {
  count = length(var.public_subnets_cidr)
  allocation_id = aws_eip.Project_eip[count.index].id
  subnet_id = aws_subnet.Project_public_subnets[count.index].id
  depends_on = [aws_internet_gateway.Project_igw]
}