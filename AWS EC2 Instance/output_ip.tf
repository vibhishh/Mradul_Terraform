#Output Elastic IP
output "ec2_public_ip" {
  description = "The Elastic IP of the EC2 instance"
  value       = aws_eip.my_eip.public_ip
}
