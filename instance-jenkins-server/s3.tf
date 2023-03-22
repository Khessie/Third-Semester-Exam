resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "mytfstatebucket"

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "dev"
  }
}
