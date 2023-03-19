#backend
terraform {

  backend "s3" {
    bucket = "mytfstatebucket"
    key    = "/eks/terraform.tfstate"
    region = "eu-west-2"
  }

}
