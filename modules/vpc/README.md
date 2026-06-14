# VPC Module

Creates the VPC network foundation for the Secure Internal Access Platform.

## Resources

- 1 VPC with DNS support and DNS hostnames enabled
- 1 Internet Gateway
- 1 Public Route Table with `0.0.0.0/0` route to the Internet Gateway
- 2 public subnets associated with the Public Route Table
- 2 private application subnets
- 1 private security subnet

## Inputs

| Name | Description | Type |
| --- | --- | --- |
| `project_name` | Project name for naming and tags | `string` |
| `vpc_cidr` | VPC CIDR block | `string` |
| `az_count` | Number of availability zones, fixed at 2 | `number` |
| `public_subnet_cidrs` | Public subnet CIDR blocks | `list(string)` |
| `private_app_subnet_cidrs` | Private application subnet CIDR blocks | `list(string)` |
| `private_security_subnet_cidrs` | Private security subnet CIDR blocks | `list(string)` |
| `tags` | Additional resource tags | `map(string)` |

## Outputs

| Name | Description |
| --- | --- |
| `vpc_id` | VPC ID |
| `vpc_cidr_block` | VPC CIDR block |
| `internet_gateway_id` | Internet Gateway ID |
| `public_subnet_ids` | Public subnet IDs |
| `private_app_subnet_ids` | Private application subnet IDs |
| `private_security_subnet_ids` | Private security subnet IDs |
| `public_route_table_id` | Public route table ID |
| `availability_zones` | Selected availability zones |
