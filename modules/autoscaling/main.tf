resource "aws_launch_template" "service_templates" {
  count = length(var.ami)

  name = "${var.name[count.index]}-template"
  image_id = var.ami[count.index]
  instance_type = var.instance_type
  key_name = var.key_name
  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.security_group_ids
  }
}
resource "aws_autoscaling_group" "service_asgs" {
  count = length(var.ami)

  name = "${var.name[count.index]}-asg"
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id = aws_launch_template.service_templates[count.index].id
  }
  health_check_grace_period = 300
  health_check_type = "ELB"
  force_delete = true
  tag {
    key = "name"
    value = var.name[count.index]
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_attachment" "service_attachments" {
  count = length(var.ami)

  autoscaling_group_name = aws_autoscaling_group.service_asgs[count.index].id
  lb_target_group_arn = var.lb_target_group_arn[count.index]
}
