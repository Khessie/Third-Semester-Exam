resource "aws_vpc" "my-web_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env_prefix}_vpc"

  }
}

# VPC configuration
resource "aws_vpc" "my-web_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env_prefix}_vpc"

  }
}

# Public and Private Subnets configuration
resource "aws_subnet" "my-web_subnets" {
  count = 2

  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = var.availability_zone[count.index]
  vpc_id                  = aws_vpc.my-web_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "${element(var.subnet_names, count.index % length(var.subnet_names))}-publicsubnet-${count.index / length(var.subnet_names) + 1}"
  }
}

resource "aws_subnet" "private" {
  count = 2

  cidr_block        = "10.0.${count.index + 3}.0/24"
  availability_zone = var.availability_zone[count.index]
  vpc_id            = aws_vpc.my-web_vpc.id
  tags = {
    Name = "${element(var.subnet_names, count.index % length(var.subnet_names))}-privatesubnet-${count.index / length(var.subnet_names) + 1}"
  }
}


data "aws_availability_zones" "azs" {}
module "my-web-vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.19.0"
  name            = "my-web-vpc"
  cidr            = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks
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
