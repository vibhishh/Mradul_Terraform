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

variable "bucket_name" {
  description = "This is the Bucket Name based on modules."
  type = string
}

variable "table_name" {
  description = "This is the Table Name based on modules."
  type = string
}

variable "env_name" {
  description = "This is the Environment Name based on modules."
  type = string
}
