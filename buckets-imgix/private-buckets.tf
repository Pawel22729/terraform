resource "aws_s3_bucket" "private_bucket" {
  count         = length(var.s3_bucket_name)
  bucket        = "${var.s3_bucket_name[count.index]}${var.private_suffix}"
  acl           = "private"
  force_destroy = "true"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "brand"
    Environment = "${var.s3_bucket_name[count.index]}"
  }

  cors_rule {
    allowed_origins = ["*"]
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    expose_headers  = ["ETag", "x-amz-server-side-encryption", "x-amz-request-id", "x-amz-id-2"]
  }

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
      {
          "Sid": "AllowPublicRead",
          "Effect": "Allow",
          "Principal": {
              "AWS": "*"
          },
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::${var.s3_bucket_name[count.index]}${var.private_suffix}/*"
      }
  ]
}
EOF
}

resource "aws_s3_bucket_public_access_block" "private_access" {
  count  = length(var.s3_bucket_name)
  bucket = "${var.s3_bucket_name[count.index]}${var.private_suffix}"

  block_public_acls   = true
  block_public_policy = true
}