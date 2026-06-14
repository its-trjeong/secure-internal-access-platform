# Secure Internal Access Platform

Terraform implementation for the Secure Internal Access Platform network baseline in AWS `ap-northeast-2`.

## Architecture

This configuration creates only the resources defined in the provided design:

- VPC: `10.10.0.0/16`
- Internet Gateway
- Public Route Table with default route to the Internet Gateway
- Public Subnets:
  - `10.10.1.0/24`
  - `10.10.2.0/24`
- Private-App Subnets:
  - `10.10.10.0/24`
  - `10.10.11.0/24`
- Private-Security Subnet:
  - `10.10.20.0/24`

NAT Gateway, private route tables, bastion hosts, VPN, endpoints, and security workloads are intentionally not created because they are not included in the provided design.

## Requirements

- Terraform `>= 1.15.0`
- AWS provider `~> 5.0`
- AWS credentials configured for the target account

## Usage

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Inputs

Defaults are set to the provided design values. Override variables only when the architecture design changes.

## Outputs

The module outputs VPC ID, VPC CIDR, Internet Gateway ID, Public Route Table ID, subnet IDs, and selected Availability Zones.
