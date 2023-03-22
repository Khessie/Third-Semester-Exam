terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

# AWS Provider configuration
provider "aws" {
  region = "eu-west-2"
}
