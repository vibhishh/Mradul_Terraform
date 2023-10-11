resource "aws_instance" "my_ec2" {
  count = 2
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    name = var.instance_name
    }
}
