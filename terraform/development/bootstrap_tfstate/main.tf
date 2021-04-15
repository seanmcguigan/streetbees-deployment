resource "aws_kms_key" "terraformstate" {
  description = "KMS for terraform state bucket"
}

resource "aws_s3_bucket" "terraformstate" {
  bucket = "streetbees-terraformstate-development"
  acl    = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.terraformstate.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  tags = {
    Name        = "terraformstate"
    Environment = "development"
  }
}

resource "aws_dynamodb_table" "terraformstate" {
  billing_mode   = "PROVISIONED"
  hash_key       = "LockID"
  name           = "terraformstate-locking-development"
  read_capacity  = 5
  stream_enabled = false
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = false
  }
}
