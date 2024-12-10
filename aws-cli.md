# Command

Replace the default vpc and secerity group first before run

```bash
aws rds create-db-cluster \
  --engine "aurora-postgresql" \
  --engine-version "15.4" \
  --engine-lifecycle-support "open-source-rds-extended-support-disabled" \
  --engine-mode "provisioned" \
  --db-cluster-identifier "rds-aurora-console-to-code" \
  --vpc-security-group-ids "sg-xxxxxxxx" \
  --port "5432" \
  --db-cluster-parameter-group-name "default.aurora-postgresql15" \
  --database-name "rds_aurora_console_to_code" \
  --master-username "postgres" \
  --manage-master-user-password \
  --backup-retention-period "7" \
  --db-subnet-group-name "default-vpc-xxxxxxxx" \
  --enable-cloudwatch-logs-exports "postgresql" \
  --pre-signed-url "" \
  --storage-type "aurora" \
  --serverless-v2-scaling-configuration '{"MinCapacity":0.5,"MaxCapacity":1}' \
  --enable-performance-insights \
  --performance-insights-retention-period "465" \
  --monitoring-interval "0" \
  --database-insights-mode "advanced"
```
