resource "aws_default_vpc" "default_vpc" {
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Example security group for EC2 instance"

  # Define inbound and outbound rules for the security group
  # Example: Allow SSH (port 22) and HTTP (port 80) traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere (for demonstration purposes)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
