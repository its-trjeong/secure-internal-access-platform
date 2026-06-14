variable "aws_region" {
  description = "AWS region where the internal access platform will be deployed."
  type        = string
  default     = "ap-northeast-2"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string
  default     = "secure-internal-access-platform"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to use."
  type        = number
  default     = 2

  validation {
    condition     = var.az_count == 2
    error_message = "This baseline is designed for exactly 2 availability zones."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24"]

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Exactly 2 public subnet CIDR blocks are required."
  }
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets."
  type        = list(string)
  default     = ["10.10.10.0/24", "10.10.11.0/24"]

  validation {
    condition     = length(var.private_app_subnet_cidrs) == 2
    error_message = "Exactly 2 private application subnet CIDR blocks are required."
  }
}

variable "private_security_subnet_cidrs" {
  description = "CIDR blocks for private security subnets."
  type        = list(string)
  default     = ["10.10.20.0/24"]

  validation {
    condition     = length(var.private_security_subnet_cidrs) == 1
    error_message = "Exactly 1 private security subnet CIDR block is required."
  }
}

variable "tags" {
  description = "Additional tags to apply to all supported resources."
  type        = map(string)
  default = {
    Environment = "internal"
    ManagedBy   = "terraform"
  }
}
