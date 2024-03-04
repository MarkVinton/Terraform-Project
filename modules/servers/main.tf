resource "aws_instance" "Lighting_instance" {
    ami = "ami-0d18e50ca22537278"
  instance_type = "t2.micro"
  subnet_id = var.public_subnets[0]
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "Lighting"
  }
}
resource "aws_instance" "Heating_instance" {
    ami = "ami-0d18e50ca22537278"
  instance_type = "t2.micro"
  subnet_id = var.public_subnets[1]
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "Status"
  }
}
resource "aws_instance" "Status_instance" {
    ami = "ami-0d18e50ca22537278"
  instance_type = "t2.micro"
  subnet_id = var.public_subnets[2]
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "Status"
  }
}
resource "aws_instance" "auth_instance" {
    ami = "ami-0d18e50ca22537278"
  instance_type = "t2.micro"
  subnet_id = var.private_subnets[0]
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "Auth"
  }
}