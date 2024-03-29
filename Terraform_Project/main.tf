# Dev Infrastructure
module "dev-demo" {
  source = "./modules/files"
  env_name = "dev"
  instance_type = "t2.micro"
  ami_id = "ami-053b0d53c279acc90" #ubuntu
  instance_name = "demo_instance"
  bucket_name = "qrbucket1"
  table_name = "demo_table"
}

# QR Infrastructure
module "qr-demo" {
  source = "./modules/files"
  env_name = "qr"
  instance_type = "t2.small"
  ami_id = "ami-041feb57c611358bd" #amazon-linux
  instance_name = "demo_instance"
  bucket_name = "qrbucket2"
  table_name = "demo_table"
}

# PRD Infrastructure
module "prd-demo" {
  source = "./modules/files"
  env_name = "Prd"
  instance_type = "t2.medium"
  ami_id = "ami-026ebd4cfe2c043b2" #redhat
  instance_name = "demo_instance"
  bucket_name = "prdbucket3"
  table_name = "demo_table"
}
