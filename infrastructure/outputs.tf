output "load_balancer_name" {
  value = module.loadbalancing.alb_endpoint
}

output "load_balancer_arn" {
  value = module.loadbalancing.alb_target_group_arn
}