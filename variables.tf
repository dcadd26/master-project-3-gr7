variable "aws_access_key" {
  type        = string
  description = "The AWS access key for authentication"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "The AWS secret key for authentication"
  sensitive   = true
}

variable "aws_region" {
  description = "Rajoni AWS ku krijohen resurset"
  type        = string
  default     = "eu-central-1"
}

variable "group_name" {
  description = "Emri i grupit - përdoret për emërtim unik"
  type        = string
  default     = "group-7"
}

variable "vpc_cidr" {
  description = "CIDR block për VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks për 3 public subnets (1 per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks për 3 private subnets (1 per AZ)"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones në eu-central-1"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "nat_gateway_count" {
  description = "Numri i NAT Gateways (1 per AZ public)"
  type        = number
  default     = 3
}