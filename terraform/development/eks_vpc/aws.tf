provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.12.6"
  backend "s3" {
    bucket         = "streetbees-terraformstate-development"
    encrypt        = "true"
    dynamodb_table = "terraformstate-locking-development"
    kms_key_id     = "arn:aws:kms:us-east-1:994625319258:key/63b9ea8d-917c-46ed-aa92-5bc1bf198420"
    region         = "us-east-1"
    key            = "eksvpc-development/terraform.tfstate"
  }
}
