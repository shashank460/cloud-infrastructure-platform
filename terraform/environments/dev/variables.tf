variable "aws_region" { type=string default="ap-south-1" }
variable "environment" { type=string default="dev" }
variable "vpc_cidr" { type=string default="10.20.0.0/16" }
variable "cluster_name" { type=string default="cloud-platform-dev" }
variable "db_name" { type=string default="appdb" }
variable "db_username" { type=string default="appuser" }
