resource "aws_s3_bucket" "b" {
  bucket = "pablo22729-bucket"
  acl    = "private"

  tags {
    Name        = "${var.bucket_name}"
    Environment = "Dev"
  }
}
