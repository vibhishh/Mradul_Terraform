# 0. Terraform AWS Providers and region
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


# 1. VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MY_VPC"
  }
}

# 2. Public Subnet (for NAT Gateway)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Public-Subnet"
  }
}


# 3. Private Subnet (for EC2)
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Private-Subnet"
  }
}


# 4. Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MY_IGW"
  }
}

# 5. Elastic IP for NAT
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}


# 6. NAT Gateway (in Public Subnet)
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = "MY_NAT"
  }
}

# 7. Public Route Table (for Public Subnet)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-RT"
  }
}

resource "aws_route_table_association" "public_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# 8. Private Route Table (for Private Subnet via NAT)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Private-RT"
  }
}

resource "aws_route_table_association" "private_asso" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}


# 9. Private EC2 Instance (Behind NAT)
resource "aws_instance" "private_ec2" {
  subnet_id       = aws_subnet.private_subnet.id
  ami             = "ami-0360c520857e3138f"
  instance_type   = "t2.micro"
  associate_public_ip_address = false

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true

    tags = {
      Name = "ec2-ebs-volume"
    }
  }

  tags = {
    Name = "Private-EC2"
  }
}
