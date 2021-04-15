provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.12.6"
  backend "s3" {
    bucket         = "streetbees-terraformstate-development"
    encrypt        = "true"
    dynamodb_table = "terraformstate-locking-development"
    kms_key_id     = "arn:aws:kms:us-east-1:005846173450:key/1ffef6d4-e817-48ba-9544-7c5a4c64fb63"
    region         = "us-east-1"
    key            = "eks-development/terraform.tfstate"
  }
}

