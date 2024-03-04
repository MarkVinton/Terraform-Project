output "vpc_id" {
  value = aws_vpc.Project_vpc.id
}
output "public_subnets" {
  value = aws_subnet.Project_public_subnets[*].id
}
output "private_subnets" {
  value = aws_subnet.Project_private_subnets[*].id
}