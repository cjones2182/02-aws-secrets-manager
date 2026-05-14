# AWS Multi-Environment Infrastructure with Terraform

## Project Overview

Deployed a production-ready AWS infrastructure using Terraform across dev and production environments. Built custom reusable modules to enforce consistency and enable infrastructure-as-code best practices.

## Architecture Components

- VPC with public, private, and database subnets across multiple AZs
- Internet Gateway + NAT Gateway for outbound internet access
- Application Load Balancer with target group and listener
- Auto Scaling Group with launch template
- RDS Multi-AZ database with encryption
- CloudWatch alarms + SNS for real-time alerting
- S3 backend + DynamoDB for state locking

## Custom Modules Built

- vpc – VPC, subnets, IGW, NAT gateways, route tables
- security-groups – ALB, web tier, and database security groups
- alb – Load balancer, target group, listener
- autoscaling-groups – Launch template + ASG with ALB integration
- rds – Multi-AZ database
- cloudwatch – Metric alarms and SNS notifications

## Tools Used

Terraform, AWS (VPC, EC2, RDS, ALB, ASG, S3, DynamoDB, CloudWatch, SNS)

## Repository Structure

- modules/ – Custom reusable modules
- dev/ – Development environment
- production/ – Production environment
- global/ – Shared S3 + DynamoDB backend

## Sample Deployment

terraform.tfvars example:

vpc_cidr           = "10.0.0.0/16"
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
environment        = "dev"
instance_type      = "t3.micro"

Commands:

terraform init
terraform plan
terraform apply -auto-approve

## Security Practices

- All resources tagged with environment for cost tracking
- RDS encrypted at rest
- Security groups follow least-privilege access
- Remote state encrypted with AES256
- State locking prevents race conditions

## Author

[Cory Jones] 