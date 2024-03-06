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
  target_type = "instance"
  health_check {
    path = "/api/lights/health"
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
    path = "/api/heating/health"
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
    path = "/api/status/health"
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
    path = "/api/auth"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "Lighting_attachment" {
  target_group_arn = aws_lb_target_group.lighting_tg.arn
  target_id = var.Lighting_instance_id
  port = 3000
}
resource "aws_lb_target_group_attachment" "Heating_attachment" {
  target_group_arn = aws_lb_target_group.heating_tg.arn
  target_id = var.Heating_instance_id
  port = 3000
}
resource "aws_lb_target_group_attachment" "Status_attachment" {
  target_group_arn = aws_lb_target_group.status_tg.arn
  target_id = var.Status_instance_id
  port = 3000
}
resource "aws_lb_target_group_attachment" "Auth_attachment" {
  target_group_arn = aws_lb_target_group.auth_tg.arn
  target_id = var.Auth_instance_id
  port = 3000
}
resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.public_lb.arn
  port = 3000
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lighting_tg.arn
  }
}
resource "aws_lb_listener_rule" "heating_rule" {
  listener_arn = aws_lb_listener.public_listener.arn
  priority = 95
  action {
    target_group_arn = aws_lb_target_group.heating_tg.arn
    type = "forward"
  }
  condition {
    path_pattern {
      values = ["/api/heating"]
    }
  }
}
resource "aws_lb_listener_rule" "status_rule" {
  listener_arn = aws_lb_listener.public_listener.arn
  priority = 90
  action {
    target_group_arn = aws_lb_target_group.status_tg.arn
    type = "forward"
  }
  condition {
    path_pattern {
      values = ["/api/status"]
    }
  }
}
resource "aws_lb_listener_rule" "auth_rule" {
  listener_arn = aws_lb_listener.public_listener.arn
  priority = 82
  action {
    target_group_arn = aws_lb_target_group.auth_tg.arn
    type = "forward"
  }
  condition {
    path_pattern {
      values = ["/api/auth"]
    }
  }
}



