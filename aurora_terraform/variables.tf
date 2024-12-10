variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "cluster_identifier" {
  description = "The identifier for the RDS cluster"
  type        = string
  default     = "rds-aurora-console-to-code"
}

variable "database_name" {
  description = "The name of the database to create"
  type        = string
  default     = "rds_aurora_console_to_code"
}

variable "master_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "postgres"
}

variable "security_group_id" {
  description = "VPC Security Group ID"
  type        = string
  default     = "sg-09dfbfb45a551f09a"
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group"
  type        = string
  default     = "default-vpc-08b0f21ff827d6b88"
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}

variable "db_cluster_parameter_group_name" {
  description = "Name of the DB cluster parameter group"
  type        = string
  default     = "default.aurora-postgresql15"
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}
