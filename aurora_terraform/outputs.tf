output "cluster_endpoint" {
  description = "The cluster endpoint"
  value       = aws_rds_cluster.aurora_cluster.endpoint
}

output "cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_rds_cluster.aurora_cluster.reader_endpoint
}

output "cluster_identifier" {
  description = "The RDS cluster identifier"
  value       = aws_rds_cluster.aurora_cluster.cluster_identifier
}

output "database_name" {
  description = "The database name"
  value       = aws_rds_cluster.aurora_cluster.database_name
}

output "port" {
  description = "The database port"
  value       = aws_rds_cluster.aurora_cluster.port
}

output "master_username" {
  description = "The master username for the database"
  value       = aws_rds_cluster.aurora_cluster.master_username
}
