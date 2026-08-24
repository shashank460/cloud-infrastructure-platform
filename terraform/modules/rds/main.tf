variable "name" { type=string }
variable "environment" { type=string }
variable "subnet_ids" { type=list(string) }
variable "vpc_id" { type=string }
variable "db_name" { type=string }
variable "db_username" { type=string }
resource "aws_db_subnet_group" "this" { name="${var.name}-db-subnets" subnet_ids=var.subnet_ids }
resource "aws_security_group" "db" { name="${var.name}-db" vpc_id=var.vpc_id description="PostgreSQL security group; restrict ingress to application security group in production." }
resource "aws_db_instance" "this" { identifier="${var.name}-postgres" engine="postgres" engine_version="16" instance_class="db.t4g.micro" allocated_storage=20 db_name=var.db_name username=var.db_username manage_master_user_password=true db_subnet_group_name=aws_db_subnet_group.this.name vpc_security_group_ids=[aws_security_group.db.id] skip_final_snapshot=true publicly_accessible=false }
output "endpoint" { value=aws_db_instance.this.address }
