#!/bin/bash
# setup_aurora.sh

# Create directory for the project
mkdir -p aurora_terraform
cd aurora_terraform

# Create main.tf
cat > main.tf << 'EOF'
provider "aws" {
  region = var.aws_region
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier        = var.cluster_identifier
  engine                   = "aurora-postgresql"
  engine_version           = "15.4"
  engine_mode              = "provisioned"
  database_name            = var.database_name
  master_username          = var.master_username
  manage_master_user_password = true
  
  vpc_security_group_ids   = [var.security_group_id]
  db_subnet_group_name     = var.db_subnet_group_name
  port                     = var.port
  
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  backup_retention_period  = var.backup_retention_period
  
  storage_type = "aurora"
  
  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 1.0
  }
  
  enable_cloudwatch_logs_exports = ["postgresql"]
  
  enable_performance_insights = true
  performance_insights_retention_period = 465
  
  monitoring_interval = 0
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  cluster_identifier        = aws_rds_cluster.aurora_cluster.id
  instance_class           = "db.serverless"
  engine                   = aws_rds_cluster.aurora_cluster.engine
  engine_version           = aws_rds_cluster.aurora_cluster.engine_version
  performance_insights_enabled = true
}
EOF

# Create variables.tf
cat > variables.tf << 'EOF'
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
EOF

# Create outputs.tf
cat > outputs.tf << 'EOF'
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
EOF

# Create terraform.tfvars (optional - for custom values)
cat > terraform.tfvars << 'EOF'
# Replace security_group_id and db_subnet_group_name first before running
aws_region = "us-west-2"
cluster_identifier = "rds-aurora-console-to-code"
database_name = "rds_aurora_console_to_code"
master_username = "postgres"
security_group_id = "sg-xxxxxx"
db_subnet_group_name = "default-vpc-xxxxxxx"
port = 5432
db_cluster_parameter_group_name = "default.aurora-postgresql15"
backup_retention_period = 7
EOF

# Make the script executable
chmod +x setup_aurora.sh

# Initialize and apply Terraform (uncomment these lines if you want automatic execution)
# terraform init
# terraform plan
# terraform apply -auto-approve

echo "Terraform configuration files have been created successfully!"
echo "To deploy the infrastructure:"
echo "1. Review and modify terraform.tfvars if needed"
echo "2. Run: terraform init"
echo "3. Run: terraform plan"
echo "4. Run: terraform apply"
