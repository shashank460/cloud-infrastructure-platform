# Deployment security checklist

## Terraform remote state

Bootstrap the backend before running the application stack:

```bash
cd terraform/bootstrap
terraform init
terraform apply
```

The dev environment then uses the S3 backend with DynamoDB locking. Never commit `.tfstate` or real `.tfvars` files.

## EKS API access

Set `eks_public_access_cidrs` to a trusted VPN, office, or runner egress CIDR. Do not use `0.0.0.0/0`.

For the strongest posture, move CI to a self-hosted runner inside the VPC and disable public EKS endpoint access entirely.

## GitHub environment protection

The deploy job targets the `production` environment. In GitHub repository settings:

1. Create the `production` environment.
2. Add required reviewers.
3. Restrict deployment branches to `main`.
4. Add `AWS_DEPLOY_ROLE_ARN` as an environment secret.

This prevents a normal push from becoming an unreviewed production deployment.

## GHCR

The deploy workflow creates a short-lived Kubernetes Docker registry secret from the GitHub Actions token. The repository/package must allow the workflow to read the container image.

## Security scanning

CI runs Checkov against Terraform/Kubernetes/Dockerfile and Trivy filesystem scanning for high/critical vulnerabilities, secrets, and misconfiguration.
