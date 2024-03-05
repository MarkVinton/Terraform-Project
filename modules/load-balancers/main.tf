resource "aws_lb" "public_lb" {
  name = "Public-Load-Balancer"
  internal = false
  load_balancer_type = "application"
  security_groups = var.security_group_ids
  subnets = var.public_subnets
  enable_deletion_protection = false
}
resource "aws_lb" "private_lb" {
  name = "Private-Load-Balancer"
  internal = true
  load_balancer_type = "application"
  security_groups = var.security_group_ids
  subnets = var.private_subnets
}

resource "aws_lb_target_group" "lighting_tg" {
  name = "Lighting"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check {
    path = "/health-check"
    protocol = "HTTP"
  }
}
resource "aws_lb_target_group" "heating_tg" {
  name = "Heating"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "instance"
  health_check {
    path = "/health-check"
    protocol = "HTTP"
  }
}
resource "aws_lb_target_group" "status_tg" {
  name = "Status"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "instance"
  health_check {
    path = "/health-check"
    protocol = "HTTP"
  }
}
resource "aws_lb_target_group" "auth_tg" {
  name = "auth"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "instance"
  health_check {
    path = "/health-check"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "Lighting" {
  target_group_arn = aws_lb_target_group.lighting_tg.arn
  target_id = var.Lighting_instance_id
  port = 3000
}
resource "aws_lb_target_group_attachment" "Heating" {
  target_group_arn = aws_lb_target_group.lighting_tg.arn
  target_id = var.Heating_instance_id
  port = 3000
}
resource "aws_lb_target_group_attachment" "Status" {
  target_group_arn = aws_lb_target_group.lighting_tg.arn
  target_id = var.Status_instance_id
  port = 3000
}
resource "aws_lb_target_group_attachment" "Auth" {
  target_group_arn = aws_lb_target_group.lighting_tg.arn
  target_id = var.Auth_instance_id
  port = 3000
}
resource "aws_lb_listener" "lighting_listener" {
  load_balancer_arn = aws_lb.public_lb.arn
  port = 3000
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lighting_tg.arn
  }
}
resource "aws_lb_listener_rule" "name" {
  listener_arn = aws_lb_listener.lighting_listener.arn
  action {
    target_group_arn = aws_lb_target_group.lighting_tg.arn
    type = "forward"
  }
  condition {
    path_pattern {
      values = ["/api/lighting"]
    }
  }
}