resource "aws_instance" "Lighting_instance" {
    ami = "ami-0ca4e6c42a6f72cf3"
  instance_type = "t2.micro"
  key_name = "key-ED25519"	
  subnet_id = var.public_subnets[0]
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = true
  tags = {
    Name = "Lighting"
  }
}
resource "aws_instance" "Heating_instance" {
    ami = "ami-092661c89a95fb9ad"
  instance_type = "t2.micro"
  key_name = "key-ED25519"
  subnet_id = var.public_subnets[1]
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = true
  tags = {
    Name = "Heating"
  }
}
resource "aws_instance" "Status_instance" {
    ami = "ami-0d18e50ca22537278"
  instance_type = "t2.micro"
  key_name = "key-ED25519"	
  subnet_id = var.public_subnets[2]
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = true
  tags = {
    Name = "Status"
  }
}
resource "aws_instance" "auth_instance" {
    ami = "ami-0d18e50ca22537278"
  instance_type = "t2.micro"
  key_name = "key-ED25519"	
  subnet_id = var.private_subnets[0]
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "Auth"
  }
}