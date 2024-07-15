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

resource "mongodbatlas_cluster" "atlas_cluster" {
  project_id = mongodbatlas_project.atlas_project.id
  name = "${var.atlas_project_name}-cluster"
  cluster_type = "REPLICASET"
  provider_instance_size_name = "M0"
  provider_name = "TENANT"
  backing_provider_name = "AWS"
  provider_region_name = "US_EAST_1"
  replication_specs {
    num_shards = 1

    regions_config {
      region_name     = "US_EAST_1"
      electable_nodes = 3
      priority        = 7
    }
  }
}