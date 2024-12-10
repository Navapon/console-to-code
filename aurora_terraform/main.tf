provider "aws" {
  region  = var.aws_region
  version = "5.80"
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier          = var.cluster_identifier
  engine                      = "aurora-postgresql"
  engine_version              = "15.4"
  engine_mode                 = "provisioned"
  database_name               = var.database_name
  master_username             = var.master_username
  manage_master_user_password = true

  # vpc_security_group_ids = [var.security_group_id]
  # db_subnet_group_name   = var.db_subnet_group_name
  port                            = var.port
  performance_insights_enabled    = true
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  backup_retention_period         = var.backup_retention_period

  storage_type = "aurora"

  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 1.0
  }

  enabled_cloudwatch_logs_exports = ["postgresql"]

  performance_insights_retention_period = 465

}

resource "aws_rds_cluster_instance" "aurora_instance" {
  cluster_identifier           = aws_rds_cluster.aurora_cluster.id
  instance_class               = "db.serverless"
  engine                       = aws_rds_cluster.aurora_cluster.engine
  engine_version               = aws_rds_cluster.aurora_cluster.engine_version
  performance_insights_enabled = true
}
