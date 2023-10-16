#These variables are for EC2 Instance

variable "ami_id" {
  description = "This is the AMI ID based on modules."
  type = string
}

variable "instance_type" {
  description = "This is the Instance-Type based on modules."
  type = string
}

variable "instance_name" {
  description = "This is the Instance-Name based on modules."
  type = string
}

#These variables are for S3 Bucket


variable "bucket_name" {
  description = "This is the Bucket Name based on modules."
  type = string
}

#These variables are for DynamoDB


variable "table_name" {
  description = "This is the Table Name based on modules."
  type = string
}

#These variables are for RDS

*/variable "rds_db_admin" {
}

variable "rds_db_password" {
}

variable "multi_az" {
}

variable "db_name" {
}

variable "engine_version" {
}

variable "allocated_storage" {
}

variable "instance_class" {
}

variable "db_engine" {
}/*

#ENV variable


variable "env_name" {
  description = "This is the Environment Name based on modules."
  type = string
}
