variable "ami_id" {
  default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  default = "ec2_instance"
}

variable "bucket_name" {
  default = "unique_s3_bucket_1"
}

variable "table_name" {
  default = "mradul_table"
}
