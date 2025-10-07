terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~>5.0.0"
      }
    }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "rand" {
  byte_length = 4
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "mradul-${random_id.rand.hex}"
}

resource "aws_s3_object" "obj" {
    bucket = aws_s3_bucket.my_bucket.bucket
    key = "testfile.html"
    source = "./testfile.html"
    etag   = filemd5("./testfile.html")

  content_type = "text/html"
}

resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.my_bucket.bucket
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
      }
    ]
  })
}
