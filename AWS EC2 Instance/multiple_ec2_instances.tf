module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

 for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"
 
  ami                   = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  key_name               = "AmazonEC2"
  monitoring             = true
 }

