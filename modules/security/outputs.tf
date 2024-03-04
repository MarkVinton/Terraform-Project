output "security_group_ids" {
  description = "List of all security groups"
  value = [aws_security_group.allow_egress.id,aws_security_group.allow_http.id,aws_security_group.allow_https.id]
}