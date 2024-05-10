provider "aws" {
  region = var.aws_region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

# Create public subnets
resource "aws_subnet" "public" {
  count                     = 2
  vpc_id                    = aws_vpc.main.id
  cidr_block                = element(var.public_subnet_cidrs, count.index)
  map_public_ip_on_launch   = true  # Enable public IP assignment
  availability_zone         = element(var.availability_zones, count.index)
}

# Create private subnets
resource "aws_subnet" "private" {
  count                     = 2
  vpc_id                    = aws_vpc.main.id
  cidr_block                = element(var.private_subnet_cidrs, count.index)
  availability_zone         = element(var.availability_zones, count.index)
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Create a route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

# Create a route in the public route table to direct traffic to the Internet Gateway
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"  # Route for all traffic
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {}

# Create a NAT Gateway in the first public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
}

# Create a route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

# Create a route in the private route table to direct traffic to the NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"  # Route for all traffic
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
