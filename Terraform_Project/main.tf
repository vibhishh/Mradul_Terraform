# Dev Infrastructure
module "dev-demo" {
  source = "./modules/files"
  env_name = "DEV"
  instance_type = "t2.micro"
  ami_id = "ami-053b0d53c279acc90" #ubuntu
  instance_name = "demo_instance"
  bucket_name = "vibhish_bucket1"
  table_name = "demo_table"
}

# QR Infrastructure
module "qr-demo" {
  source = "./modules/files"
  env_name = "QR"
  instance_type = "t2.small"
  ami_id = "ami-041feb57c611358bd" #amazon-linux
  instance_name = "demo_instance"
  bucket_name = "vibhish_bucket2"
  table_name = "demo_table"
}

# PRD Infrastructure
module "prd-demo" {
  source = "./modules/files"
  env_name = "PRD"
  instance_type = "t2.medium"
  ami_id = "ami-026ebd4cfe2c043b2" #redhat
  instance_name = "demo_instance"
  bucket_name = "vibhish_bucket3"
  table_name = "demo_table"
}
