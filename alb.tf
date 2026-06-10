resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "${var.group_name}-master-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  tags = {
    Name        = "${var.group_name}-master-tg"
    Project     = "DCADD_MASTER"
    Environment = "DEV"
    Description = "Target group for EC2 instances"
  }
}

resource "aws_lb" "app_alb" {
  name               = "${var.group_name}-master-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = aws_subnet.public[*].id

  tags = {
    Name        = "${var.group_name}-master-alb"
    Project     = "DCADD_MASTER"
    Environment = "DEV"
    Description = "Internet-facing Application Load Balancer"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}