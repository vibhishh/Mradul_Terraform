resource "aws_route_table_association" "private_rt_asso" {
  subnet_id = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private_rt.id
}