locals {
  vpc_cidr = "10.123.0.0/16"
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "Security group for public access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.sg_access_ip]
        }
        http = {
            from = 80
            to = 80
            protocol = "tcp"
            cidr_blocks = [var.sg_access_ip]
        }
      }
    }
    rds = {
        name = "rds_sg"
        description = "RDS Security Group"
        ingress = {
            rds = {
                from = 3306
                to = 3306
                protocol = "tcp"
                cidr_blocks = [local.vpc_cidr]
            }
        }
    }
  }
}