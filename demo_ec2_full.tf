########################################
# Provider
########################################
provider "aws" {
  region = "ap-south-1" # Change to your region
}

########################################
# VPC & Subnet (using default VPC)
########################################
resource "aws_default_vpc" "default" {}

resource "aws_default_subnet" "default_subnet" {
  availability_zone = "ap-south-1a"
}

########################################
# Security Group
########################################
resource "aws_security_group" "my_sg" {
  name        = "ec2-sg"
  description = "Allow SSH & HTTP"
  vpc_id      = aws_default_vpc.default.id

 ingress = [
    for port in [22, 80, 443, 8080, 9000,9100,9090,3000] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

########################################
# Key Pair (replace with your public key)
########################################
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

########################################
# IAM Role + Policy (optional)
########################################
resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name
}

########################################
# EC2 Instance
########################################
resource "aws_instance" "ec2" {
  ami                    = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name               = aws_key_pair.my_key.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  monitoring             = true # enable detailed monitoring

  # Run script at boot
  user_data = file("userdata.sh")

  # Root volume
  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true
  }

  # Extra EBS volume
  ebs_block_device {
    device_name           = "/dev/sdf"
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name        = "Full-EC2"
    Environment = "Dev"
    Owner       = "Mradul"
  }
}

########################################
# Elastic IP
########################################
resource "aws_eip" "ec2_eip" {
  instance = aws_instance.ec2.id
  vpc      = true
}

########################################
# Outputs
########################################
output "ec2_public_ip" {
  value = aws_eip.ec2_eip.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.ec2.private_ip
}

output "ec2_public_dns" {
  value = aws_instance.ec2.public_dns
}

output "security_group_id" {
  value = aws_security_group.my_sg.id
}

output "instance_id" {
  value = aws_instance.ec2.id
}
