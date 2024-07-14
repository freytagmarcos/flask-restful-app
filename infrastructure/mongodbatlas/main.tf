resource "mongodbatlas_project" "atlas_project" {
  org_id = var.org_id
  name = var.atlas_project_name
}

resource "random_password" "db_password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "mongodbatlas_database_user" "db_user" {
  username = var.username
  password = random_password.db_password.result
  project_id = mongodbatlas_project.atlas_project.id
  auth_database_name = "admin"
  roles {
    role_name = "readWrite"
    database_name = "${var.atlas_project_name}-db"
  }
}

resource "mongodbatlas_project_ip_access_list" "aws_ip" {
  project_id = mongodbatlas_project.atlas_project.id
  cidr_block = var.cidr_block
}

resource "mongodbatlas_advanced_cluster" "atlas_cluster" {
  project_id = mongodbatlas_project.atlas_project.id
  name = "${var.atlas_project_name}-cluster"
  cluster_type = "SHARED"
  replication_specs {
    region_configs {
      electable_specs {
        instance_size = "M0 Sandbox"
      }
      analytics_specs {
        instance_size = "M0 Sandbox"
      }
      provider_name = "AWS"
      priority      = 7
      region_name   = "US_EAST_1"
    }
  }
}