data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  public_subnets = {
    for index, cidr in var.public_subnet_cidrs : index => {
      cidr_block        = cidr
      availability_zone = data.aws_availability_zones.available.names[index]
    }
  }

  private_app_subnets = {
    for index, cidr in var.private_app_subnet_cidrs : index => {
      cidr_block        = cidr
      availability_zone = data.aws_availability_zones.available.names[index]
    }
  }

  private_security_subnets = {
    for index, cidr in var.private_security_subnet_cidrs : index => {
      cidr_block        = cidr
      availability_zone = data.aws_availability_zones.available.names[index]
    }
  }

  common_tags = merge(
    var.tags,
    {
      Project = var.project_name
    }
  )
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-vpc"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-igw"
  })
}

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-public-${tonumber(each.key) + 1}"
    Tier = "public"
  })
}

resource "aws_subnet" "private_app" {
  for_each = local.private_app_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-private-app-${tonumber(each.key) + 1}"
    Tier = "private-app"
  })
}

resource "aws_subnet" "private_security" {
  for_each = local.private_security_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-private-security-${tonumber(each.key) + 1}"
    Tier = "private-security"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
