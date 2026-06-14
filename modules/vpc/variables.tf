variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "az_count" {
  description = "Number of availability zones to use."
  type        = number

  validation {
    condition     = var.az_count == 2
    error_message = "This VPC module expects exactly 2 availability zones."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == var.az_count
    error_message = "The number of public subnet CIDR blocks must match az_count."
  }
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets."
  type        = list(string)

  validation {
    condition     = length(var.private_app_subnet_cidrs) == var.az_count
    error_message = "The number of private application subnet CIDR blocks must match az_count."
  }
}

variable "private_security_subnet_cidrs" {
  description = "CIDR blocks for private security subnets."
  type        = list(string)

  validation {
    condition     = length(var.private_security_subnet_cidrs) == 1
    error_message = "Exactly 1 private security subnet CIDR block is required."
  }
}

variable "tags" {
  description = "Additional tags to apply to all supported resources."
  type        = map(string)
  default     = {}
}
