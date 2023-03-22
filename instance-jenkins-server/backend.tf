#backend
terraform {

  backend "s3" {
    bucket = "mytfstatebucket"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }

}
