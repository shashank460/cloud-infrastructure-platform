# Monitoring and alerting

Terraform now provisions CloudWatch observability resources for each environment:

- RDS CPU utilization alarm (>80% for two 5-minute periods)
- RDS database-connection alarm (>80 connections for two 5-minute periods)
- CloudWatch dashboard with RDS CPU and connection metrics
- Application log-group target for `/aws/eks/<cluster>/application`

The alarms intentionally have no hard-coded SNS email address. For a real deployment, connect the alarms to an SNS topic owned by the environment and subscribe an operational address.

After `terraform apply`, retrieve the dashboard name with:

```bash
terraform output monitoring_dashboard
```

For recruiter evidence, capture:
1. GitHub Actions CI passing.
2. Terraform plan artifact.
3. CloudWatch dashboard.
4. A successful Kubernetes rollout.
