terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.66.1"
    }
  }

  backend "s3" {
    bucket         = "my-bucket-57356c717f7c3895" #replace bucket_name accordingly
    dynamodb_table = "my_dynamodb_gR0DcN" #replace dynamoDB_table_name accordingly
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true #used for encryption of our statefile at s3
  }
}
