output "load_balancer_dns" {
  value = aws_lb.public_lb.dns_name
}
output "lights_target_group" {
  value = aws_lb_target_group.lighting_tg.arn
}
output "heating_target" {
  value = aws_lb_target_group.heating_tg.arn
}
output "status_target" {
  value = aws_lb_target_group.status_tg.arn
}
output "auth_target" {
  value = aws_lb_target_group.auth_tg_private.arn
}