terraform {
  required_version = ">= 1.6.0"
  backend "s3" {
    bucket = "shashank-cloud-platform-tfstate"
    key = "cloud-platform/staging/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    dynamodb_table = "shashank-cloud-platform-tf-locks"
  }
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 6.0" }
  }
}

provider "aws" {
  region = "ap-south-1"
  default_tags { tags = { Project = "cloud-infrastructure-platform", Environment = "staging", ManagedBy = "terraform" } }
}

variable "eks_public_access_cidrs" { type = list(string) }

module "network" {
  source = "../../modules/network"
  name = "cloud-platform-staging"
  vpc_cidr = "10.30.0.0/16"
  environment = "staging"
}
module "eks" {
  source = "../../modules/eks"
  cluster_name = "cloud-platform-staging"
  environment = "staging"
  private_subnet_ids = module.network.private_subnet_ids
  public_access_cidrs = var.eks_public_access_cidrs
}
module "rds" {
  source = "../../modules/rds"
  name = "cloud-platform-staging"
  environment = "staging"
  subnet_ids = module.network.private_subnet_ids
  vpc_id = module.network.vpc_id
  db_name = "appdb"
  db_username = "appuser"
  app_security_group_id = module.eks.node_security_group_id
}
module "s3" {
  source = "../../modules/s3"
  name = "cloud-platform-staging"
  environment = "staging"
}
