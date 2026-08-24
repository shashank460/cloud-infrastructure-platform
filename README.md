# Production Cloud Infrastructure Platform

A production-oriented cloud/DevOps project demonstrating Infrastructure as Code, containerization, Kubernetes, AWS networking, managed database/storage, CI/CD, secrets, monitoring, and zero-downtime application delivery.

## Architecture

```text
GitHub -> GitHub Actions -> Terraform -> AWS VPC -> EKS
                         \-> Docker -> Container Registry -> EKS
EKS -> Nginx Ingress -> Node.js API -> RDS PostgreSQL / S3
```

## Stack
- AWS: VPC, EKS, RDS PostgreSQL, S3, IAM, CloudWatch
- Terraform
- Docker
- Kubernetes
- GitHub Actions
- Nginx Ingress
- Node.js demo API
- Health/readiness probes
- Rolling deployments
- Kubernetes Secrets

## Safety
This repository contains infrastructure code only. It does not contain AWS credentials, state files, passwords, or private keys.

Before applying Terraform, configure AWS credentials locally or through GitHub OIDC, review cost, and provide database/application secrets securely. The default configuration is infrastructure code and is not a claim that resources are already deployed.
