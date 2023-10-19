# Create a security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "RDS security group"
}

# Create an RDS instance
resource "aws_db_instance" "mradul_rds" {
  allocated_storage    = 20 # Storage_Size
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "mraduldb"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id] # Associate the RDS instance with the security group

  tags = {
    Name = "mradul-rds"
  }
}

