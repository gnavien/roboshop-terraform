terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}