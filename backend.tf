terraform {
  backend "s3" {
    bucket         = "tf-state-secure-sg-cleanup-1761792941"
    key            = "secure-sg-cleanup/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
