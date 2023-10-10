provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo_s3" {
  bucket = "mradul_singh_s3" 
# Bucket name always be unique
}
