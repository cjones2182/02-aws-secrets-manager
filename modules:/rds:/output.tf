output "rds_database" {
  description = "rds database DbInstanceIdentifier"
  value = aws_db_instance.main-rds.arn
}