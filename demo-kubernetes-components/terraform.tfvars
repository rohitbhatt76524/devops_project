# ─────────────────────────────────────────────────────
#  terraform.tfvars — TESTING CONFIG (cheap, 6hr use)
#  Switch node_instance_type to t3.medium for production
# ─────────────────────────────────────────────────────

region             = "ap-south-1"
cluster_name       = "my-eks-cluster"
cluster_version    =  "1.32"        #was "1.29"

vpc_cidr           = "10.0.0.0/16"
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.10.0/24", "10.0.11.0/24"]

# For testing — cheapest node type
node_instance_type = "t3.small"
node_desired_size  = 1
node_min_size      = 1
node_max_size      = 2

# Switch to below for production:
# node_instance_type = "t3.medium"
# node_desired_size  = 2
# node_min_size      = 1
# node_max_size      = 4
