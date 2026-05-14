resource "random_password" "rds_password" {
 length =  16
 special = true
}
resource "aws_secretsmanager_secret" "rds_secret" {
  name = "rds-secret"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.rds_username
    password = random_password.rds_password
  })
}