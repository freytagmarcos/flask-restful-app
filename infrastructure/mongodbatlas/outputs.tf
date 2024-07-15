output "atlas_cluster_connection_string" { 
        value = mongodbatlas_cluster.atlas_cluster.connection_strings.0.standard_srv 
    }
output "username" {
        value = mongodbatlas_database_user.db_user.username
    } 
output "user_password" { 
        sensitive = true
        value = mongodbatlas_database_user.db_user.password 
    }