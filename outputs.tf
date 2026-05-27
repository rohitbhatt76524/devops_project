output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "node_username" {
  description = "SSH username for the EKS node"
  value       = "ec2-user"
}

output "node_password" {
  description = "SSH password for the EKS node — run: terraform output -raw node_password"
  value       = random_password.node.result
  sensitive   = true
}

output "kubeconfig_command" {
  description = "Run this to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name}"
}
