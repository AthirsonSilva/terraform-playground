# Provider configuration variables
variable "aws_region" {
  description = "AWS region to use"
  type        = string
  default     = "sa-east-1"
}

# VPC configuration variables
variable "vpc_cidr" {
  description = "CIDR block for main VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Availability zones configuration variable
variable "availability_zones" {
  description = "AWS availability zones to use"
  type        = list(string)
  default     = ["sa-east-1a"]
}