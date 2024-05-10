# Output the VPC ID
output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

# Output the IDs of the public subnets
output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = aws_subnet.public.*.id
}

# Output the IDs of the private subnets
output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = aws_subnet.private.*.id
}

# Output the ID of the Internet Gateway
output "internet_gateway_id" {
  description = "The ID of the internet gateway."
  value       = aws_internet_gateway.igw.id
}

# Output the ID of the NAT Gateway
output "nat_gateway_id" {
  description = "The ID of the NAT gateway."
  value       = aws_nat_gateway.nat.id
}
