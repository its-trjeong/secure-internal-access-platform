variable "aws_region" {
  description = "AWS region where the platform will be deployed."
  type        = string
  default     = "ap-northeast-2"
}

variable "project_name" {
  description = "Project name used for resource names and tags."
  type        = string
  default     = "secure-internal-access-platform"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones used by public and private app subnets."
  type        = number
  default     = 2

  validation {
    condition     = var.az_count == 2
    error_message = "This design requires exactly 2 availability zones."
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
  description = "Additional tags applied to supported resources."
  type        = map(string)
  default = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
