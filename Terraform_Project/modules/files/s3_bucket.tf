resource "aws_s3_bucket" "my_demo_bucket" {
    bucket = "${var.bucket_name}"
}
