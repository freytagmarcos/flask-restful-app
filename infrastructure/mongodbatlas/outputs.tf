output "atlas_cluster_endpoint" { 
        value = mongodbatlas_cluster.atlas_cluster.mongo_uri 
    }
output "atlas_cluster_username" {
        value = mongodbatlas_database_user.db_user.username
    } 
output "atlas_cluster_password" { 
        sensitive = true
        value = mongodbatlas_database_user.db_user.password 
    }