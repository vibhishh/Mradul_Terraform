#Elastic IP for ec2

resource "aws_eip" "my_eip" {
  instance = aws_instance.my_ec2.id
  domain   = "vpc"

  tags = {
    Name = "my-eip"
  }
}
