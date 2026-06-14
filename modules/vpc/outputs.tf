output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC."
  value       = aws_vpc.this.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = aws_internet_gateway.this.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = [for key in sort(keys(aws_subnet.public)) : aws_subnet.public[key].id]
}

output "private_app_subnet_ids" {
  description = "IDs of the private application subnets."
  value       = [for key in sort(keys(aws_subnet.private_app)) : aws_subnet.private_app[key].id]
}

output "private_security_subnet_ids" {
  description = "IDs of the private security subnets."
  value       = [for key in sort(keys(aws_subnet.private_security)) : aws_subnet.private_security[key].id]
}

output "public_route_table_id" {
  description = "ID of the public route table."
  value       = aws_route_table.public.id
}

output "availability_zones" {
  description = "Availability zones selected for the VPC."
  value       = distinct(concat(
    [for subnet in local.public_subnets : subnet.availability_zone],
    [for subnet in local.private_app_subnets : subnet.availability_zone],
    [for subnet in local.private_security_subnets : subnet.availability_zone]
  ))
}
