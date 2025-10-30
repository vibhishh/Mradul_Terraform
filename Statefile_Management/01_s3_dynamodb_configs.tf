#terraform provider for AWS
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0.0"
    }
  }
}


#AWS Provider
provider "aws" {
  region = "us-east-1"
}

#random_id used to help us to create unique name for S3 and DynamoDB.
resource "random_id" "rand_s3" {
  byte_length = 8
}

#random_str used to help us to create unique name for S3 and DynamoDB. Both Random_id and random_str works almost the same
resource "random_string" "rand_str_dynamodb" {
  length = 6
  lower = true
  upper = true
  special = false
}

#S3 bucket creation for storing tf statefile
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-${random_id.rand_s3.hex}"

  versioning {
    enabled = true
  }
}

#DynamoDB creation which is used for statelocking 
resource "aws_dynamodb_table" "my_dynamo_db" {
  name = "my_dynamodb_${random_string.rand_str_dynamodb.result}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
