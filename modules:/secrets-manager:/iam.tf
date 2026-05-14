

data "aws_iam_policy_document" "rds_login" {
    statement {
        sid    = "EnableResourcetogetRDSPassword"
    effect = "Allow"


    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["aws_secretsmanager_secret.rds_secret.arn"] #input db secret arn
  }

}
  