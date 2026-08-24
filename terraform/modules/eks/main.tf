variable "cluster_name" { type=string }
variable "environment" { type=string }
variable "private_subnet_ids" { type=list(string) }
data "aws_iam_policy_document" "cluster_assume" { statement { actions=["sts:AssumeRole"] principals { type="Service" identifiers=["eks.amazonaws.com"] } } }
resource "aws_iam_role" "cluster" { name="${var.cluster_name}-cluster-role" assume_role_policy=data.aws_iam_policy_document.cluster_assume.json }
resource "aws_iam_role_policy_attachment" "cluster" { role=aws_iam_role.cluster.name policy_arn="arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" }
resource "aws_eks_cluster" "this" { name=var.cluster_name role_arn=aws_iam_role.cluster.arn vpc_config { subnet_ids=var.private_subnet_ids endpoint_private_access=true endpoint_public_access=true } depends_on=[aws_iam_role_policy_attachment.cluster] }
output "cluster_name" { value=aws_eks_cluster.this.name }
