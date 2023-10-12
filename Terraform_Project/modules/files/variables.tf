variable "ami_id" {
  description = "This is the AMI ID based on modules."
  type = "S"
}

variable "instance_type" {
  description = "This is the Instance-Type based on modules."
  type = "S"
}

variable "instance_name" {
  description = "This is the Instance-Name based on modules."
  type = "S"
}

variable "bucket_name" {
  description = "This is the Bucket Name based on modules."
  type = "S"
}

variable "table_name" {
  description = "This is the Table Name based on modules."
  type = "S"
}

variable "env_name" {
  description = "This is the Environment Name based on modules."
  type = "S"
}
