Started by user admin
Obtained eks-Jenkinsfile from git https://github.com/Khessie/Third-Semester-Exam
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/creating-eks-cluster
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified

> git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/creating-eks-cluster/.git # timeout=10
> Fetching changes from the remote Git repository
> git config remote.origin.url https://github.com/Khessie/Third-Semester-Exam # timeout=10
> Fetching upstream changes from https://github.com/Khessie/Third-Semester-Exam
> git --version # timeout=10
> git --version # 'git version 2.34.1'
> git fetch --tags --force --progress -- https://github.com/Khessie/Third-Semester-Exam +refs/heads/_:refs/remotes/origin/_ # timeout=10
> git rev-parse refs/remotes/origin/main^{commit} # timeout=10
> Checking out Revision 516717292bd3739ce8c6ae5108afd8070b89e8db (refs/remotes/origin/main)
> git config core.sparsecheckout # timeout=10
> git checkout -f 516717292bd3739ce8c6ae5108afd8070b89e8db # timeout=10
> Commit message: "Delete newfile"
> git rev-list --no-walk 516717292bd3739ce8c6ae5108afd8070b89e8db # timeout=10
> [Pipeline] }
> [Pipeline] // stage
> [Pipeline] withEnv
> [Pipeline] {
> [Pipeline] withCredentials
> Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
> [Pipeline] {
> [Pipeline] withEnv
> [Pipeline] {
> [Pipeline] stage
> [Pipeline] { (Create an EKS Cluster)
> [Pipeline] script
> [Pipeline] {
> [Pipeline] dir
> Running in /var/lib/jenkins/workspace/creating-eks-cluster/eks-cluster
> [Pipeline] {
> [Pipeline] sh

- terraform init

[0m[1mInitializing the backend...[0m

[0m[1mInitializing provider plugins...[0m

- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/tls from the dependency lock file
- Using previously-installed hashicorp/aws v3.76.1
- Using previously-installed hashicorp/tls v4.0.4

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
[Pipeline] sh

- terraform apply -auto-approve
  [0m[1maws_vpc.main: Refreshing state... [id=vpc-069cf2a3ecac7dcd1][0m
  [0m[1maws_eip.nat: Refreshing state... [id=eipalloc-0d60ca3093d49dcfd][0m
  [0m[1maws_internet_gateway.igw: Refreshing state... [id=igw-0dfe96bff12663fb8][0m
  [0m[1maws_subnet.public-us-east-1a: Refreshing state... [id=subnet-07a3b41d0fd59b819][0m
  [0m[1maws_subnet.private-us-east-1b: Refreshing state... [id=subnet-0d292003744b96b76][0m
  [0m[1maws_subnet.public-us-east-1b: Refreshing state... [id=subnet-0b6e21df5d2b76106][0m
  [0m[1maws_subnet.private-us-east-1a: Refreshing state... [id=subnet-0bcd2ff2082cfc0a0][0m
  [0m[1maws_route_table.public: Refreshing state... [id=rtb-08a7d9007d6d0428e][0m
  [0m[1maws_nat_gateway.nat: Refreshing state... [id=nat-03f1076e493af1c8d][0m
  [0m[1maws_route_table_association.public-us-east-1a: Refreshing state... [id=rtbassoc-0d0e519843b03a900][0m
  [0m[1maws_route_table_association.public-us-east-1b: Refreshing state... [id=rtbassoc-08faaba4d67e31d50][0m
  [0m[1maws_route_table.private: Refreshing state... [id=rtb-0c07ee8e0e2e698fb][0m
  [0m[1maws_route_table_association.private-us-east-1b: Refreshing state... [id=rtbassoc-05daa9cf3b64aa5f6][0m
  [0m[1maws_route_table_association.private-us-east-1a: Refreshing state... [id=rtbassoc-09329bb3fa518a327][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
[32m+[0m create[0m
[36m<=[0m read (data resources)[0m

Terraform will perform the following actions:

[1m # data.aws_iam_policy_document.eks_cluster_autoscaler_assume_role_policy[0m will be read during apply

# (config refers to values not yet known)

[0m [36m<=[0m[0m data "aws_iam_policy_document" "eks_cluster_autoscaler_assume_role_policy" {
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m json = (known after apply)

      [32m+[0m[0m statement {
          [32m+[0m[0m actions = [
              [32m+[0m[0m "sts:AssumeRoleWithWebIdentity",
            ]
          [32m+[0m[0m effect  = "Allow"

          [32m+[0m[0m condition {
              [32m+[0m[0m test     = "StringEquals"
              [32m+[0m[0m values   = [
                  [32m+[0m[0m "system:serviceaccount:kube-system:cluster-autoscaler",
                ]
              [32m+[0m[0m variable = (known after apply)
            }

          [32m+[0m[0m principals {
              [32m+[0m[0m identifiers = [
                  [32m+[0m[0m (known after apply),
                ]
              [32m+[0m[0m type        = "Federated"
            }
        }
    }

[1m # data.aws_iam_policy_document.test_oidc_assume_role_policy[0m will be read during apply

# (config refers to values not yet known)

[0m [36m<=[0m[0m data "aws_iam_policy_document" "test_oidc_assume_role_policy" {
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m json = (known after apply)

      [32m+[0m[0m statement {
          [32m+[0m[0m actions = [
              [32m+[0m[0m "sts:AssumeRoleWithWebIdentity",
            ]
          [32m+[0m[0m effect  = "Allow"

          [32m+[0m[0m condition {
              [32m+[0m[0m test     = "StringEquals"
              [32m+[0m[0m values   = [
                  [32m+[0m[0m "system:serviceaccount:default:aws-test",
                ]
              [32m+[0m[0m variable = (known after apply)
            }

          [32m+[0m[0m principals {
              [32m+[0m[0m identifiers = [
                  [32m+[0m[0m (known after apply),
                ]
              [32m+[0m[0m type        = "Federated"
            }
        }
    }

[1m # data.tls_certificate.eks[0m will be read during apply

# (config refers to values not yet known)

[0m [36m<=[0m[0m data "tls_certificate" "eks" {
[32m+[0m[0m certificates = (known after apply)
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m url = (known after apply)
}

[1m # aws_eks_cluster.demo[0m will be created
[0m [32m+[0m[0m resource "aws_eks_cluster" "demo" {
[32m+[0m[0m arn = (known after apply)
[32m+[0m[0m certificate_authority = (known after apply)
[32m+[0m[0m created_at = (known after apply)
[32m+[0m[0m endpoint = (known after apply)
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m identity = (known after apply)
[32m+[0m[0m name = "demo"
[32m+[0m[0m platform_version = (known after apply)
[32m+[0m[0m role_arn = (known after apply)
[32m+[0m[0m status = (known after apply)
[32m+[0m[0m tags_all = (known after apply)
[32m+[0m[0m version = (known after apply)

      [32m+[0m[0m vpc_config {
          [32m+[0m[0m cluster_security_group_id = (known after apply)
          [32m+[0m[0m endpoint_private_access   = false
          [32m+[0m[0m endpoint_public_access    = true
          [32m+[0m[0m public_access_cidrs       = (known after apply)
          [32m+[0m[0m subnet_ids                = [
              [32m+[0m[0m "subnet-07a3b41d0fd59b819",
              [32m+[0m[0m "subnet-0b6e21df5d2b76106",
              [32m+[0m[0m "subnet-0bcd2ff2082cfc0a0",
              [32m+[0m[0m "subnet-0d292003744b96b76",
            ]
          [32m+[0m[0m vpc_id                    = (known after apply)
        }
    }

[1m # aws_eks_node_group.private-nodes[0m will be created
[0m [32m+[0m[0m resource "aws_eks_node_group" "private-nodes" {
[32m+[0m[0m ami_type = (known after apply)
[32m+[0m[0m arn = (known after apply)
[32m+[0m[0m capacity_type = "ON_DEMAND"
[32m+[0m[0m cluster_name = "demo"
[32m+[0m[0m disk_size = (known after apply)
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m instance_types = [
[32m+[0m[0m "t3.small",
]
[32m+[0m[0m labels = {
[32m+[0m[0m "role" = "general"
}
[32m+[0m[0m node_group_name = "private-nodes"
[32m+[0m[0m node_group_name_prefix = (known after apply)
[32m+[0m[0m node_role_arn = (known after apply)
[32m+[0m[0m release_version = (known after apply)
[32m+[0m[0m resources = (known after apply)
[32m+[0m[0m status = (known after apply)
[32m+[0m[0m subnet_ids = [
[32m+[0m[0m "subnet-0bcd2ff2082cfc0a0",
[32m+[0m[0m "subnet-0d292003744b96b76",
]
[32m+[0m[0m tags_all = (known after apply)
[32m+[0m[0m version = (known after apply)

      [32m+[0m[0m scaling_config {
          [32m+[0m[0m desired_size = 2
          [32m+[0m[0m max_size     = 5
          [32m+[0m[0m min_size     = 0
        }

      [32m+[0m[0m update_config {
          [32m+[0m[0m max_unavailable = 1
        }
    }

[1m # aws_iam_openid_connect_provider.eks[0m will be created
[0m [32m+[0m[0m resource "aws_iam_openid_connect_provider" "eks" {
[32m+[0m[0m arn = (known after apply)
[32m+[0m[0m client_id_list = [
[32m+[0m[0m "sts.amazonaws.com",
]
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m tags_all = (known after apply)
[32m+[0m[0m thumbprint_list = (known after apply)
[32m+[0m[0m url = (known after apply)
}

[1m # aws_iam_policy.eks_cluster_autoscaler[0m will be created
[0m [32m+[0m[0m resource "aws_iam_policy" "eks_cluster_autoscaler" {
[32m+[0m[0m arn = (known after apply)
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m name = "eks-cluster-autoscaler"
[32m+[0m[0m path = "/"
[32m+[0m[0m policy = jsonencode(
{
[32m+[0m[0m Statement = [
[32m+[0m[0m {
[32m+[0m[0m Action = [
[32m+[0m[0m "autoscaling:DescribeAutoScalingGroups",
[32m+[0m[0m "autoscaling:DescribeAutoScalingInstances",
[32m+[0m[0m "autoscaling:DescribeLaunchConfigurations",
[32m+[0m[0m "autoscaling:DescribeTags",
[32m+[0m[0m "autoscaling:SetDesiredCapacity",
[32m+[0m[0m "autoscaling:TerminateInstanceInAutoScalingGroup",
[32m+[0m[0m "ec2:DescribeLaunchTemplateVersions",
]
[32m+[0m[0m Effect = "Allow"
[32m+[0m[0m Resource = "*"
},
]
[32m+[0m[0m Version = "2012-10-17"
}
)
[32m+[0m[0m policy_id = (known after apply)
[32m+[0m[0m tags_all = (known after apply)
}

[1m # aws_iam_policy.test-policy[0m will be created
[0m [32m+[0m[0m resource "aws_iam_policy" "test-policy" {
[32m+[0m[0m arn = (known after apply)
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m name = "test-policy"
[32m+[0m[0m path = "/"
[32m+[0m[0m policy = jsonencode(
{
[32m+[0m[0m Statement = [
[32m+[0m[0m {
[32m+[0m[0m Action = [
[32m+[0m[0m "s3:ListAllMyBuckets",
[32m+[0m[0m "s3:GetBucketLocation",
]
[32m+[0m[0m Effect = "Allow"
[32m+[0m[0m Resource = "arn:aws:s3:::*"
},
]
[32m+[0m[0m Version = "2012-10-17"
}
)
[32m+[0m[0m policy_id = (known after apply)
[32m+[0m[0m tags_all = (known after apply)
}

[1m # aws_iam_role.demo[0m will be created
[0m [32m+[0m[0m resource "aws_iam_role" "demo" {
[32m+[0m[0m arn = (known after apply)
[32m+[0m[0m assume_role_policy = jsonencode(
{
[32m+[0m[0m Statement = [
[32m+[0m[0m {
[32m+[0m[0m Action = "sts:AssumeRole"
[32m+[0m[0m Effect = "Allow"
[32m+[0m[0m Principal = {
[32m+[0m[0m Service = "eks.amazonaws.com"
}
},
]
[32m+[0m[0m Version = "2012-10-17"
}
)
[32m+[0m[0m create_date = (known after apply)
[32m+[0m[0m force_detach_policies = false
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m managed_policy_arns = (known after apply)
[32m+[0m[0m max_session_duration = 3600
[32m+[0m[0m name = "eks-cluster-demo"
[32m+[0m[0m name_prefix = (known after apply)
[32m+[0m[0m path = "/"
[32m+[0m[0m tags_all = (known after apply)
[32m+[0m[0m unique_id = (known after apply)
}

[1m # aws_iam_role.eks_cluster_autoscaler[0m will be created
[0m [32m+[0m[0m resource "aws_iam_role" "eks_cluster_autoscaler" {
[32m+[0m[0m arn = (known after apply)
[32m+[0m[0m assume_role_policy = (known after apply)
[32m+[0m[0m create_date = (known after apply)
[32m+[0m[0m force_detach_policies = false
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m managed_policy_arns = (known after apply)
[32m+[0m[0m max_session_duration = 3600
[32m+[0m[0m name = "eks-cluster-autoscaler"
[32m+[0m[0m name_prefix = (known after apply)
[32m+[0m[0m path = "/"
[32m+[0m[0m tags_all = (known after apply)
[32m+[0m[0m unique_id = (known after apply)
}

[1m # aws_iam_role.nodes[0m will be created
[0m [32m+[0m[0m resource "aws_iam_role" "nodes" {
[32m+[0m[0m arn = (known after apply)
[32m+[0m[0m assume_role_policy = jsonencode(
{
[32m+[0m[0m Statement = [
[32m+[0m[0m {
[32m+[0m[0m Action = "sts:AssumeRole"
[32m+[0m[0m Effect = "Allow"
[32m+[0m[0m Principal = {
[32m+[0m[0m Service = "ec2.amazonaws.com"
}
},
]
[32m+[0m[0m Version = "2012-10-17"
}
)
[32m+[0m[0m create_date = (known after apply)
[32m+[0m[0m force_detach_policies = false
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m managed_policy_arns = (known after apply)
[32m+[0m[0m max_session_duration = 3600
[32m+[0m[0m name = "eks-node-group-nodes"
[32m+[0m[0m name_prefix = (known after apply)
[32m+[0m[0m path = "/"
[32m+[0m[0m tags_all = (known after apply)
[32m+[0m[0m unique_id = (known after apply)
}

[1m # aws_iam_role.test_oidc[0m will be created
[0m [32m+[0m[0m resource "aws_iam_role" "test_oidc" {
[32m+[0m[0m arn = (known after apply)
[32m+[0m[0m assume_role_policy = (known after apply)
[32m+[0m[0m create_date = (known after apply)
[32m+[0m[0m force_detach_policies = false
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m managed_policy_arns = (known after apply)
[32m+[0m[0m max_session_duration = 3600
[32m+[0m[0m name = "test-oidc"
[32m+[0m[0m name_prefix = (known after apply)
[32m+[0m[0m path = "/"
[32m+[0m[0m tags_all = (known after apply)
[32m+[0m[0m unique_id = (known after apply)
}

[1m # aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy[0m will be created
[0m [32m+[0m[0m resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
[32m+[0m[0m role = "eks-cluster-demo"
}

[1m # aws_iam_role_policy_attachment.eks_cluster_autoscaler_attach[0m will be created
[0m [32m+[0m[0m resource "aws_iam_role_policy_attachment" "eks_cluster_autoscaler_attach" {
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m policy_arn = (known after apply)
[32m+[0m[0m role = "eks-cluster-autoscaler"
}

[1m # aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly[0m will be created
[0m [32m+[0m[0m resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
[32m+[0m[0m role = "eks-node-group-nodes"
}

[1m # aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy[0m will be created
[0m [32m+[0m[0m resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
[32m+[0m[0m role = "eks-node-group-nodes"
}

[1m # aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy[0m will be created
[0m [32m+[0m[0m resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
[32m+[0m[0m role = "eks-node-group-nodes"
}

[1m # aws_iam_role_policy_attachment.test_attach[0m will be created
[0m [32m+[0m[0m resource "aws_iam_role_policy_attachment" "test_attach" {
[32m+[0m[0m id = (known after apply)
[32m+[0m[0m policy_arn = (known after apply)
[32m+[0m[0m role = "test-oidc"
}

[1mPlan:[0m 15 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
[32m+[0m[0m eks_cluster_autoscaler_arn = (known after apply)
[32m+[0m[0m test_policy_arn = (known after apply)
[0m[1maws_iam_policy.eks_cluster_autoscaler: Creating...[0m[0m
[0m[1maws_iam_role.demo: Creating...[0m[0m
[0m[1maws_iam_role.nodes: Creating...[0m[0m
[0m[1maws_iam_policy.test-policy: Creating...[0m[0m
[0m[1maws_iam_policy.eks_cluster_autoscaler: Creation complete after 1s [id=arn:aws:iam::104697772276:policy/eks-cluster-autoscaler][0m
[0m[1maws_iam_policy.test-policy: Creation complete after 1s [id=arn:aws:iam::104697772276:policy/test-policy][0m
[0m[1maws_iam_role.nodes: Creation complete after 1s [id=eks-node-group-nodes][0m
[0m[1maws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy: Creating...[0m[0m
[0m[1maws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy: Creating...[0m[0m
[0m[1maws_iam_role.demo: Creation complete after 1s [id=eks-cluster-demo][0m
[0m[1maws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly: Creating...[0m[0m
[0m[1maws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy: Creating...[0m[0m
[0m[1maws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy: Creation complete after 1s [id=eks-node-group-nodes-20230322204519865000000001][0m
[0m[1maws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy: Creation complete after 1s [id=eks-node-group-nodes-20230322204519867100000002][0m
[0m[1maws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy: Creation complete after 1s [id=eks-cluster-demo-20230322204519890500000003][0m
[0m[1maws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly: Creation complete after 1s [id=eks-node-group-nodes-20230322204519898600000004][0m
[0m[1maws_eks_cluster.demo: Creating...[0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [20s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [30s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [40s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [50s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [1m0s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [1m10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [1m20s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [1m30s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [1m40s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [1m50s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [2m0s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [2m10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [2m20s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [2m30s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [2m40s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [2m50s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [3m0s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [3m10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [3m20s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [3m30s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [3m40s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [3m50s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [4m0s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [4m10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [4m20s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [4m30s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [4m40s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [4m50s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [5m0s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [5m10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [5m20s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [5m30s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [5m40s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [5m50s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [6m0s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [6m10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [6m20s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [6m30s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [6m40s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [6m50s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [7m0s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [7m10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [7m20s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [7m30s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [7m40s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [7m50s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [8m0s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [8m10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [8m20s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [8m30s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [8m40s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [8m50s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [9m0s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [9m10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [9m20s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [9m30s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [9m40s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [9m50s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [10m0s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Still creating... [10m10s elapsed][0m[0m
[0m[1maws_eks_cluster.demo: Creation complete after 10m12s [id=demo][0m
[0m[1mdata.tls_certificate.eks: Reading...[0m[0m
[0m[1maws_eks_node_group.private-nodes: Creating...[0m[0m
[0m[1mdata.tls_certificate.eks: Read complete after 0s [id=8cb781b6037f4703f17f42d8de4a2c2aa78474ab][0m
[0m[1maws_iam_openid_connect_provider.eks: Creating...[0m[0m
[0m[1maws_iam_openid_connect_provider.eks: Creation complete after 1s [id=arn:aws:iam::104697772276:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/52148227EC30887B1FFACAB8C0DBA7F0][0m
[0m[1mdata.aws_iam_policy_document.test_oidc_assume_role_policy: Reading...[0m[0m
[0m[1mdata.aws_iam_policy_document.eks_cluster_autoscaler_assume_role_policy: Reading...[0m[0m
[0m[1mdata.aws_iam_policy_document.eks_cluster_autoscaler_assume_role_policy: Read complete after 0s [id=2218648117][0m
[0m[1mdata.aws_iam_policy_document.test_oidc_assume_role_policy: Read complete after 0s [id=2776731728][0m
[0m[1maws_iam_role.eks_cluster_autoscaler: Creating...[0m[0m
[0m[1maws_iam_role.test_oidc: Creating...[0m[0m
[0m[1maws_iam_role.test_oidc: Creation complete after 2s [id=test-oidc][0m
[0m[1maws_iam_role.eks_cluster_autoscaler: Creation complete after 2s [id=eks-cluster-autoscaler][0m
[0m[1maws_iam_role_policy_attachment.eks_cluster_autoscaler_attach: Creating...[0m[0m
[0m[1maws_iam_role_policy_attachment.test_attach: Creating...[0m[0m
[0m[1maws_iam_role_policy_attachment.eks_cluster_autoscaler_attach: Creation complete after 1s [id=eks-cluster-autoscaler-20230322205535267400000006][0m
[0m[1maws_iam_role_policy_attachment.test_attach: Creation complete after 1s [id=test-oidc-20230322205535308700000007][0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [10s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [20s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [30s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [40s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [50s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [1m0s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [1m10s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [1m20s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [1m30s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [1m40s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Still creating... [1m50s elapsed][0m[0m
[0m[1maws_eks_node_group.private-nodes: Creation complete after 1m52s [id=demo:private-nodes][0m
[0m[1m[32m
Apply complete! Resources: 15 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0meks_cluster_autoscaler_arn = "arn:aws:iam::104697772276:role/eks-cluster-autoscaler"
test_policy_arn = "arn:aws:iam::104697772276:role/test-oidc"
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (destroy an EKS Cluster)
Stage "destroy an EKS Cluster" skipped due to when conditional
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
