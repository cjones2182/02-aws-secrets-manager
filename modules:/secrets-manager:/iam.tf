

data "aws_iam_policy_document" "rds_login" {
    statement {
        sid    = "EnableResourcetogetRDSPassword"
    effect = "Allow"


    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["aws_secretsmanager_secret.rds_secret.arn"] #input db secret arn
  }

}
  resource "aws_secretsmanager_secret_policy" "name" {
    secret_arn = aws_secretsmanager_secret.rds_secret.arn
    policy = data.aws_iam_policy_document.rds_login.json
  }