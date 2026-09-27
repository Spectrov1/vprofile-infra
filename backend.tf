terraform {
  backend "s3" {
    bucket = "gitops-terraformcode86440"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}