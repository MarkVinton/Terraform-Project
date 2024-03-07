resource "aws_launch_template" "lighting_template" {
  name = "lights-template"
  image_id = "ami-0d0a2a750f418d96b"
  instance_type = "t2.micro"
  key_name = "key-ED25519"
  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.security_group_ids
  }
}
resource "aws_autoscaling_group" "lights_asg" {
  name = "lights-asg"
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id = aws_launch_template.lighting_template.id
  }
  health_check_grace_period = 300
  health_check_type = "ELB"
  force_delete = true
  tag {
    key = "name"
    value = "NC-ASG"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_attachment" "lights_attachment" {
  autoscaling_group_name = aws_autoscaling_group.lights_asg.id
  lb_target_group_arn = var.lights_target
}
resource "aws_launch_template" "heating_template" {
  name = "heating-template1"
  image_id = "ami-0e7bec81f92034d91"
  instance_type = "t2.micro"
  key_name = "key-ED25519"
  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.security_group_ids
  }
}
resource "aws_autoscaling_group" "heating_asg" {
  name = "heating-asg"
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id = aws_launch_template.heating_template.id
  }
  health_check_grace_period = 300
  health_check_type = "ELB"
  force_delete = true
  tag {
    key = "name"
    value = "heating-ASG"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_attachment" "Heating_attachment" {
  autoscaling_group_name = aws_autoscaling_group.heating_asg.id
  lb_target_group_arn = var.heating_target
}
resource "aws_launch_template" "status_template" {
  name = "status-template1"
  image_id = "ami-057c61ee0a8cafeb0"
  instance_type = "t2.micro"
  key_name = "key-ED25519"
  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.security_group_ids
  }
  tags = {
    Name = "status"
  }
}
resource "aws_autoscaling_group" "status_asg" {
  name = "status-asg"
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id = aws_launch_template.status_template.id
  }
  health_check_grace_period = 300
  health_check_type = "ELB"
  force_delete = true
  tag {
    key = "name"
    value = "status-ASG"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_attachment" "Status_attachment" {
  autoscaling_group_name = aws_autoscaling_group.status_asg.id
  lb_target_group_arn = var.status_target
}
resource "aws_launch_template" "auth_template" {
  name = "auth-template1"
  image_id = "ami-085502d28061bd806"
  instance_type = "t2.micro"
  key_name = "key-ED25519"
  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.security_group_ids
  }
}
resource "aws_autoscaling_group" "auth_asg" {
  name = "auth-asg"
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id = aws_launch_template.auth_template.id
  }
  health_check_grace_period = 300
  health_check_type = "ELB"
  force_delete = true
  tag {
    key = "name"
    value = "auth-ASG"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_attachment" "auth_attachment" {
  autoscaling_group_name = aws_autoscaling_group.auth_asg.id
  lb_target_group_arn = var.auth_target
}