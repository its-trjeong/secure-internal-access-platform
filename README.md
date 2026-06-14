# Secure Internal Access Platform

Terraform baseline for an enterprise internal network in AWS `ap-northeast-2`.

## Architecture

This implementation follows only the provided architecture design.

- VPC CIDR: `10.10.0.0/16`
- Public subnets:
  - `10.10.1.0/24`
  - `10.10.2.0/24`
- Private-App subnets:
  - `10.10.10.0/24`
  - `10.10.11.0/24`
- Private-Security subnet:
  - `10.10.20.0/24`
- Internet Gateway: 1
- Public Route Table: 1
- Terraform: `>= 1.15.0`

NAT Gateway, private route tables, VPN, bastion hosts, and VPC endpoints are not created because they are not part of the provided design.

## Layout

```text
.
|-- main.tf
|-- variables.tf
|-- outputs.tf
|-- versions.tf
|-- README.md
|-- modules
|   `-- vpc
|       |-- main.tf
|       |-- variables.tf
|       |-- outputs.tf
|       |-- versions.tf
|       `-- README.md
`-- terraform
    |-- main.tf
    |-- variables.tf
    |-- outputs.tf
    |-- versions.tf
    `-- README.md
```

## Usage

```bash
cd terraform
terraform init
terraform fmt -recursive
terraform validate
terraform plan
```
