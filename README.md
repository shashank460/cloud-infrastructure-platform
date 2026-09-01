# Production Cloud Infrastructure Platform

[![CI](https://github.com/shashank460/cloud-infrastructure-platform/actions/workflows/ci.yml/badge.svg)](https://github.com/shashank460/cloud-infrastructure-platform/actions/workflows/ci.yml)

A production-oriented cloud/DevOps project demonstrating Infrastructure as Code, containerization, Kubernetes, AWS networking, managed database/storage, CI/CD, security scanning, monitoring, and zero-downtime application delivery.

## Architecture

```text
GitHub -> GitHub Actions -> Terraform -> AWS VPC -> EKS
                         \-> Docker -> GHCR -> EKS
EKS -> Nginx Ingress -> Node.js API -> RDS PostgreSQL / S3
                              |
                         CloudWatch
```

## Stack

- AWS: VPC, EKS, RDS PostgreSQL, S3, IAM, CloudWatch
- Terraform + S3 remote state + DynamoDB locking
- Docker + GitHub Container Registry
- Kubernetes + Nginx Ingress
- GitHub Actions + AWS OIDC
- TFLint + Checkov + Trivy
- CloudWatch dashboard and alarms
- Health/readiness probes, rolling deployments, HPA, PDB and NetworkPolicy

## Environments and promotion

Terraform has isolated `dev`, `staging`, and `prod` environment directories. Each environment uses a separate remote-state key. CI validates and generates a plan for all three environments on every push/PR.

Promotion to production is intentionally protected by the GitHub `production` environment in the deployment workflow. Production deployment should require reviewer approval before AWS credentials are exposed to the job.

## Terraform quality gates

CI runs:

1. `terraform fmt -check`
2. `terraform validate`
3. `terraform plan` with a saved plan artifact
4. TFLint
5. Checkov Terraform/Kubernetes/Dockerfile scans
6. Trivy filesystem and container-image scans
7. Node.js application tests

## Monitoring

Terraform provisions CloudWatch resources including an RDS CPU alarm, RDS connection alarm, and a dashboard. See [`docs/monitoring.md`](docs/monitoring.md) for the operational evidence checklist.

## Recruiter evidence

Once AWS is deployed, add screenshots here for:

- Passing GitHub Actions pipeline
- Terraform plan artifact
- EKS rollout
- CloudWatch dashboard and alarms
- Live HTTPS endpoint

Do not add simulated screenshots or claim a live deployment until the resources have actually been provisioned and verified.

## Safety

This repository does not contain AWS credentials, Terraform state, passwords, or private keys. Database credentials are managed by AWS RDS rather than committed to source control.

Before applying Terraform, bootstrap the remote-state S3 bucket and DynamoDB lock table, configure AWS OIDC, provide a trusted EKS API CIDR, review estimated AWS cost, and configure the production environment approval rule.
