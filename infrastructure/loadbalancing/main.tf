#--- loadbalancing/main.tf ---

resource "aws_lb" "mtc_alb" {
  name = var.alb_name
  subnets = var.public_subnets
  security_groups = [var.security_groups]
  idle_timeout = 400
}

resource "aws_alb_target_group" "mtc_tg" {
  name = "mtc-lb-tg-${substr(uuid(), 0 , 3)}"
  port = var.tg_port
  protocol = var.tg_protocol
  vpc_id = var.vpc_id
  lifecycle {
    ignore_changes = [ name ]
    create_before_destroy = true
  }
  health_check {
    healthy_threshold = var.alb_healthy_threshold
    unhealthy_threshold = var.alb_unhealthy_threshold
    timeout = var.alb_timeout
    interval = var.alb_interval
  }
}

resource "aws_lb_listener" "mtc_lb_listener" {
  load_balancer_arn = aws_lb.mtc_alb.arn
  port = var.listener_port
  protocol = var.listener_protocol
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.mtc_tg.arn
  }
}