variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "cluster_name" {
  type    = string
  default = "cloud-platform-dev"
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type    = string
  default = "appuser"
}

variable "eks_public_access_cidrs" {
  description = "Trusted public CIDRs allowed to reach the EKS Kubernetes API. Set this to your VPN/office/GitHub runner egress CIDR; never use 0.0.0.0/0."
  type        = list(string)
}
