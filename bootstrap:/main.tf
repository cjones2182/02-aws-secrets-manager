
provider "aws" {
  region = "us-east-1"
}
# =====================================================================================
# s3 bucket to hold terraform 
# =====================================================================================
resource "aws_s3_bucket" "terraform_lock_state" {
  bucket = "terraform-lock-cory-1232"

  lifecycle {
    prevent_destroy = true
  }
}
# =====================================================================================
# block public acls
# =====================================================================================
resource "aws_s3_bucket_public_access_block" "terraform_lock_public_access" {
  bucket = aws_s3_bucket.terraform_lock_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ======================================================================================
# s3 versioning
# ======================================================================================
resource "aws_s3_bucket_versioning" "terraform_lock_versioning" {
  bucket = aws_s3_bucket.terraform_lock_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
# ======================================================================================
# s3 sse
# ======================================================================================

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_sse_terraform" {
  bucket = aws_s3_bucket.terraform_lock_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
# =====================================================================================
# dynamo db to to control terraform state lock control 
# =====================================================================================
resource "aws_dynamodb_table" "dynamodb_lock_control" {
  name         = "terraform-lock-control"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

