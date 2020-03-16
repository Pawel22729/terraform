resource "aws_s3_bucket" "public_bucket" {
  count         = length(var.s3_bucket_name)
  bucket        = "${var.public_prefix}${var.s3_bucket_name[count.index]}${var.public_suffix}"
  acl           = "public-read"
  force_destroy = "true"

  tags = {
    Name        = "brand"
    Environment = "${var.s3_bucket_name[count.index]}"
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
          "Resource": "arn:aws:s3:::${var.public_prefix}${var.s3_bucket_name[count.index]}${var.public_suffix}/*"
      }
  ]
}
EOF
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  count  = length(var.s3_bucket_name)
  bucket = "${var.public_prefix}${var.s3_bucket_name[count.index]}${var.public_suffix}"

  block_public_acls   = false
  block_public_policy = false
}
