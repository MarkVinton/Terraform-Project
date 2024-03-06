output "load_balancer_dns" {
  value = aws_lb.public_lb.dns_name
}