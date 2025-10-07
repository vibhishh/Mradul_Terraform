resource "aws_instance" "public" {
  subnet_id = aws_subnet.pb-subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  ami = "ami-0360c520857e3138f"
  instance_type = "t2.micro"
  tags = {
    Name = "My-Pub-EC2"
  }
}
