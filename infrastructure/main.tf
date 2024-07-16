module "networking" {
  source = "./networking"
  vpc_cidr         = "10.123.0.0/16"
  private_sn_count = 2
  public_sn_count  = 2
  max_subnets      = 20
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet("10.123.0.0/16", 8, i)]
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet("10.123.0.0/16", 8, i)]
  access_ip        = var.sg_access_ip
  security_groups  = local.security_groups
}

module "mongodbatlas" {
  source = "./mongodbatlas"
  atlas_project_name = var.app_name
  org_id = var.org_id
  username = "username-1"
  cidr_block = var.sg_access_ip
}

module "loadbalancing" {
  source = "./loadbalancing"
  alb_name = "alb-${var.app_name}"
  public_subnets = module.networking.public_subnets
  security_groups = module.networking.alb_security_group[0]
  tg_port = var.app_port
  tg_protocol = "HTTP"
  vpc_id = module.networking.vpc_id
  alb_healthy_threshold = 2
  alb_unhealthy_threshold = 2
  alb_interval = 30
  alb_timeout = 5
  listener_port = 80
  listener_protocol = "HTTP"
}

module "ecs" {
  source = "./ecs"
  app_name = var.app_name
  app_port = var.app_port
  container_image = "${var.aws_account}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.app_name}:${var.app_version}"
  security_group = module.networking.ecs_security_group
  subnet_ids = module.networking.public_subnets
  target_group_arn = module.loadbalancing.alb_target_group_arn
  env_vars = local.container_environment
  aws_region = var.aws_region
}