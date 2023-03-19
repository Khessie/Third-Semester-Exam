resource "aws_vpc" "my-web_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env_prefix}_vpc"

  }
}

data "aws_availability_zones" "azs" {}
module "my-web-vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.19.0"
  name            = "my-web-vpc"
  cidr            = var.vpc_cidr_block
  private_subnets = ["10.0.4.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.2.0/24", "10.0.1.0/24"]
  azs             = data.aws_availability_zones.azs.names

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/my-web-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-web-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                   = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-web-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"          = 1
  }
}
