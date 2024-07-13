output "alb_target_group_arn" {
  value = aws_alb_target_group.mtc_tg.arn
}

output "alb_endpoint" {
  value = aws_lb.mtc_alb.dns_name
}