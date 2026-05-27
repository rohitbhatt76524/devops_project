variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  default     = "my-eks"
}

variable "cluster_version" {
  description = "Kubernetes version"
  default     = "1.30"
}

variable "instance_type" {
  description = "EC2 instance type for the node"
  default     = "t3.medium"
}
