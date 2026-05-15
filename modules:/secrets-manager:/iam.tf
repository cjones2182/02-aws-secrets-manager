# ===========================================================================================================
# policy document for rds secret value (json in policy)
# ===========================================================================================================

data "aws_iam_policy_document" "rds_login" {
    statement {
        sid    = "EnableResourcetogetRDSPassword"
    effect = "Allow"


    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["aws_secretsmanager_secret.rds_secret.arn"] #input db secret arn
  }
# =========================================================================================================
# actual policy with json attached to get rds secret value 
# =========================================================================================================
}
  resource "aws_secretsmanager_secret_policy" "name" {
    secret_arn = aws_secretsmanager_secret.rds_secret.arn
    policy = data.aws_iam_policy_document.rds_login.json
  }
  # ======================================================================================================
  # role for RDS secret value  
  # ===================================================================================================

  resource "aws_iam_role" "ec2_role" {
    name = "ec2-role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  }