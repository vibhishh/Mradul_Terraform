resource "aws_s3_bucket" "my_bucket" {
    bucket = "${var.env_name}-${var.bucket_name}"
}
