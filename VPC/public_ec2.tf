resource "aws_instance" "public" {
  subnet_id = aws_subnet.pb-subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  ami = "ami-0360c520857e3138f"
  instance_type = "t2.micro"
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
    delete_on_termination = true
    tags = {
      Name = "ec2-ebs-volume"
    }}
  tags = {
    Name = "My-Pub-EC2"
  }
}

