provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  az_count     = var.az_count

  public_subnet_cidrs           = var.public_subnet_cidrs
  private_app_subnet_cidrs      = var.private_app_subnet_cidrs
  private_security_subnet_cidrs = var.private_security_subnet_cidrs

  tags = var.tags
}
