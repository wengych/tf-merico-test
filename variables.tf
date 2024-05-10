# Define the AWS region to deploy resources
variable "aws_region" {
  description = "The AWS region to create resources in."
  default     = "ap-northeast-1"
}

# Define the CIDR block for the VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

# Define the CIDR blocks for the public subnets
variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Define the CIDR blocks for the private subnets
variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Define the availability zones to deploy resources
variable "availability_zones" {
  description = "The availability zones to deploy resources in."
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c"]
}
