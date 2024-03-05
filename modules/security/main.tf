data "http" "myipaddr" {
   url = "http://ipv4.icanhazip.com"
}
resource "aws_security_group" "allow_http" {
  name = "Allow HTTP Project"
  vpc_id = var.vpc_id
}
resource "aws_security_group_rule" "allow_http_ingress" {
  type = "ingress"
  from_port = 3000
  to_port = 3000
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_http.id
}
resource "aws_security_group" "allow_https" {
name = "Allow HTTPS project"
vpc_id = var.vpc_id
}
resource "aws_security_group_rule" "allow_https_ingress" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_https.id
}
resource "aws_security_group" "allow_egress" {
  name = "Allow egress"
  vpc_id = var.vpc_id
}
resource "aws_security_group_rule" "allow_egress" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  security_group_id = aws_security_group.allow_egress.id
}
resource "aws_security_group" "allow_ssh" {
  name = "Allow ssh"
  vpc_id = var.vpc_id
}
resource "aws_security_group_rule" "allow_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${chomp(data.http.myipaddr.response_body)}/32"]
  security_group_id = aws_security_group.allow_ssh.id
}
