variable "eks_public_access_cidrs" {
  description = "Trusted CIDRs allowed to reach the EKS Kubernetes API"
  type = list(string)
}
