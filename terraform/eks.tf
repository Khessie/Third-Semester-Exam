# EKS Cluster
resource "aws_eks_cluster" "k8s" {
  name     = "eks-cluster"
  role_arn = aws_iam_role.cluster.arn
  version  = "1.21"

  vpc_config {
    # security_group_ids      = [aws_security_group.eks_cluster.id, aws_security_group.eks_nodes.id]
    subnet_ids              = [aws_subnet.public-1.id, aws_subnet.public-2.id, aws_subnet.private-1.id, aws_subnet.private-2.id]
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }


  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}



# EKS Cluster IAM Role
resource "aws_iam_role" "cluster" {
  name = "${var.env_prefix}-clusterRole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
# 
# resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.cluster.name
# }


# # EKS Cluster Security Group
# resource "aws_security_group" "eks_cluster" {
#   name        = "${var.env_prefix}-cluster-sg"
#   description = "Cluster communication with worker nodes"
#   vpc_id      = aws_vpc.my-web_vpc.id

#   tags = {
#     Name = "${var.env_prefix}-cluster-sg"
#   }
# }

# resource "aws_security_group_rule" "cluster_inbound" {
#   description              = "Allow worker nodes to communicate with the cluster API Server"
#   from_port                = 443
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.eks_cluster.id
#   source_security_group_id = aws_security_group.eks_nodes.id
#   to_port                  = 443
#   type                     = "ingress"
# }

# resource "aws_security_group_rule" "cluster_outbound" {
#   description              = "Allow cluster API Server to communicate with the worker nodes"
#   from_port                = 1024
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.eks_cluster.id
#   source_security_group_id = aws_security_group.eks_nodes.id
#   to_port                  = 65535
#   type                     = "egress"
# }

# EKS Node Groups
# resource "aws_eks_node_group" "k8s_ng" {
#   cluster_name    = aws_eks_cluster.k8s.name
#   node_group_name = var.env_prefix
#   node_role_arn   = aws_iam_role.cluster.arn
#   subnet_ids      = [aws_subnet.private-1.id, aws_subnet.private-2.id]

#   scaling_config {
#     desired_size = 2
#     max_size     = 5
#     min_size     = 1
#   }
# }

# # EKS Node IAM Role
# resource "aws_iam_role" "node" {
#   name = "${var.env_prefix}-Role"

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

resource "aws_subnet" "public-1" {
  cidr_block              = "10.0.64.0/19"
  availability_zone       = var.availability_zone[0]
  vpc_id                  = aws_vpc.my-web_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name                              = "${var.env_prefix}_public-1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}
resource "aws_subnet" "public-2" {
  cidr_block              = "10.0.96.0/19"
  availability_zone       = var.availability_zone[1]
  vpc_id                  = aws_vpc.my-web_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name                              = "${var.env_prefix}_public-2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}
resource "aws_subnet" "private-1" {
  cidr_block        = "10.0.0.0/19"
  availability_zone = var.availability_zone[0]
  vpc_id            = aws_vpc.my-web_vpc.id
  tags = {
    Name                              = "${var.env_prefix}_private-1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}
resource "aws_subnet" "private-2" {
  cidr_block        = "10.0.32.0/19"
  availability_zone = var.availability_zone[1]
  vpc_id            = aws_vpc.my-web_vpc.id
  tags = {
    Name                              = "${var.env_prefix}_private-2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.test_oidc
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.cluster.name
}

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.k8s.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.cluster.arn
  subnet_ids = [
    aws_subnet.private-1.id,
    aws_subnet.private-2.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]


  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }



  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}



# Create Internet Gateway
resource "aws_internet_gateway" "my-web_internet_gateway" {
  vpc_id = aws_vpc.my-web_vpc.id
  tags = {
    Name = "${var.env_prefix}_internet_gateway"
  }
}

#NAT Elastic IP
resource "aws_eip" "nat-eip" {
  vpc = true

  tags = {
    Name = "${var.env_prefix}_nat_gateway_ip"
  }
}

#NAT Gateway Config
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public-1.id

  tags = {
    "Name" = "${var.env_prefix}_nat_gateway"
  }
}

# Route Table configuration
resource "aws_route_table" "my-web_route_table" {
  vpc_id = aws_vpc.my-web_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-web_internet_gateway.id
  }
  tags = {
    Name = "${var.env_prefix}_route_table"
  }
}

#Route Table and Subnet Association config
resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.my-web_route_table.id
}
resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.my-web_route_table.id
}
resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.my-web_route_table.id
}
resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.my-web_route_table.id
}

data "aws_iam_policy_document" "test_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:aws-test"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_policy" "test-policy" {
  name = "test-policy"

  policy = jsonencode({
    Statement = [{
      Action = [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation"
      ]
      Effect   = "Allow"
      Resource = "arn:aws:s3:::*"
    }]
    Version = "2012-10-17"
  })
}
