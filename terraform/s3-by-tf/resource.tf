resource "aws_s3_bucket" "tf_bkt" {
  bucket = "tf-s3-bkt-state-backup-a2"

  tags = {
    Name        = "tf-s3-bkt-state-backup-a2"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_bkt.id

  versioning {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.tf_bkt.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.tf_bkt.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "tf_s3_bkt_lifecycle" {
  bucket = aws_s3_bucket.tf_bkt.id

  rule {
    id     = "expire-objects"
    status = "Enabled"

    filter {
      prefix = ""
    }

    # Transition to Standard-IA after 30 days
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    # Transition to Glacier Flexible Retrieval after 60 days
    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    # Transition to Glacier Deep Archive after 120 days
    transition {
      days          = 120
      storage_class = "DEEP_ARCHIVE"
    }

    # Expire after 365 days
    expiration {
      days = 365
    }
  }
}
