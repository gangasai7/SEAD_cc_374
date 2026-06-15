# EpicBook Infrastructure Deployment using Terraform

## Project Overview

This project provisions the infrastructure required to deploy the EpicBook application on AWS using Terraform.

The infrastructure includes:

* Amazon VPC
* Public Subnet
* Private Subnets
* Internet Gateway
* Route Table
* Security Groups
* Amazon EC2 Instance
* Amazon RDS MySQL Database

---

## Architecture

User → EC2 (Node.js Application) → Amazon RDS MySQL

* EC2 is deployed in a Public Subnet.
* RDS is deployed in Private Subnets.
* Security Groups restrict database access to the EC2 instance only.

---

## Infrastructure Components

### Networking

* VPC: 10.0.0.0/16
* Public Subnet: 10.0.1.0/24
* Private Subnet 1: 10.0.2.0/24
* Private Subnet 2: 10.0.3.0/24

### Compute

* Amazon EC2
* Ubuntu Server
* Instance Type: t3.micro

### Database

* Amazon RDS MySQL
* Instance Type: db.t3.micro
* Private Accessibility

---

## Terraform Files

* provider.tf
* variables.tf
* vpc.tf
* security-groups.tf
* ec2.tf
* rds.tf
* outputs.tf

---

## Terraform Commands

Initialize Terraform:

```bash
terraform init
```

Validate Configuration:

```bash
terraform validate
```

Preview Changes:

```bash
terraform plan
```

Create Infrastructure:

```bash
terraform apply
```

Destroy Infrastructure:

```bash
terraform destroy
```

---

## Security

EC2 Security Group:

* SSH (22)
* HTTP (80)
* Application Port (8080)

RDS Security Group:

* MySQL (3306)
* Access allowed only from EC2 Security Group

---

## Project Outcome

Successfully provisioned AWS infrastructure using Terraform and deployed the EpicBook application with Amazon RDS MySQL integration.

---

## Author

Ganga Sai

DevOps | AWS | Terraform | Linux | Git | GitHub
