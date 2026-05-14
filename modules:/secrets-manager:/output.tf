output "rds_secret_arn" {
  description = "arn of rds secret"
  value = aws_secretsmanager_secret.rds_secret.arn
}
output "rds_password" {
    description = "password of rds"
    value = random_password.rds_password.result 
    sensitive = true
}
output "rds_username" {
  description = "rds username"
  value = var.rds_username
}