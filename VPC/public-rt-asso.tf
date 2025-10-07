resource "aws_route_table_association" "public_rt_asso" {
  subnet_id = aws_subnet.pb-subnet.id
  route_table_id = aws_route_table.public_rt.id
}