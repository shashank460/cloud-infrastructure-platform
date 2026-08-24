terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "name" { type = string }
variable "environment" { type = string }
variable "subnet_ids" { type = list(string) }
variable "vpc_id" { type = string }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "app_security_group_id" { type = string, default = null }

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnets"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "db" {
  name        = "${var.name}-db"
  vpc_id      = var.vpc_id
  description = "PostgreSQL access for the application workload"

  ingress {
    description     = "PostgreSQL from EKS workload security group"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = var.app_security_group_id == null ? [] : [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "this" {
  identifier                  = "${var.name}-postgres"
  engine                      = "postgres"
  engine_version              = "16"
  instance_class              = "db.t4g.micro"
  allocated_storage           = 20
  db_name                     = var.db_name
  username                    = var.db_username
  manage_master_user_password = true
  db_subnet_group_name        = aws_db_subnet_group.this.name
  vpc_security_group_ids     = [aws_security_group.db.id]
  skip_final_snapshot         = true
  publicly_accessible         = false
}

output "endpoint" { value = aws_db_instance.this.address }
output "security_group_id" { value = aws_security_group.db.id }
