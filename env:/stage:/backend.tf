
terraform {
  backend "s3" {
    bucket         = "terraform-lock-cory-1232"
    key            = "stage/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-control"
    encrypt        = true
  }
}