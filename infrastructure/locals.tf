locals {
  vpc_cidr = "10.123.0.0/16"
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "Security group for public access"
      ingress = {
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.sg_access_ip]
        }
      }
    }
    ecs = {
      name        = "ecs_sg"
      description = "ECS Security Group"
      ingress = {
        rds = {
          from        = var.app_port
          to          = var.app_port
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
        }
      }
    }
  }
}

locals {
  container_environment = [
    {
      name  = "MONGODB_HOST"
      value = substr(module.mongodbatlas.atlas_cluster_endpoint, 14, length(module.mongodbatlas.atlas_cluster_endpoint))
    },
    {
      name = "MONGODB_USER"
      value = "${module.mongodbatlas.atlas_cluster_username}"
    },
    {
      name = "MONGODB_PASSWORD"
      value = "${module.mongodbatlas.atlas_cluster_password}"
    },
        {
      name = "MONGODB_DB"
      value = "${var.app_name}-db"
    },
    {
      name  = "FLASK_ENV"
      value = "PRD"
    }
  ]
}

locals {
  log_configuration = [
    {
      logDriver = "awslogs"
      options = [
        {
          awslogs-create-group = "true"
          awslogs-region = var.aws_region
          awslogs-group = "/ecs/${var.app_name}-container"
          awslogs-stream-prefix = "ecs"
        }
      ]
    }
  ]
}
