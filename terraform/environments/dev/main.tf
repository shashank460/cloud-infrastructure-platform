module "network" {
  source = "../../modules/network"
  name = var.cluster_name
  vpc_cidr = var.vpc_cidr
  environment = var.environment
}

module "eks" {
  source = "../../modules/eks"
  cluster_name = var.cluster_name
  environment = var.environment
  private_subnet_ids = module.network.private_subnet_ids
}

module "rds" {
  source = "../../modules/rds"
  name = var.cluster_name
  environment = var.environment
  subnet_ids = module.network.private_subnet_ids
  vpc_id = module.network.vpc_id
  db_name = var.db_name
  db_username = var.db_username
  app_security_group_id = module.eks.cluster_security_group_id
}

module "s3" {
  source = "../../modules/s3"
  name = var.cluster_name
  environment = var.environment
}
