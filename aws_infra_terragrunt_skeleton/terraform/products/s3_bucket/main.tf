variable bucket_name {
  type        = string
  default     = ""
  description = "S3 bucket name"
}

module "s3-bucket" {
  source = "../../../modules/s3_bucket"

  bucket_name = var.bucket_name
}
