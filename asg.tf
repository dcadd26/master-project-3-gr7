resource "aws_autoscaling_group" "app_asg" {
  name = "${var.group_name}-master-asg"

  desired_capacity = 3
  min_size         = 2
  max_size         = 6

  vpc_zone_identifier = aws_subnet.private[*].id

  target_group_arns = [
    aws_lb_target_group.app_tg.arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.group_name}-master-ec2"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "DCADD_MASTER"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "DEV"
    propagate_at_launch = true
  }

  depends_on = [
    aws_lb_listener.http
  ]
}