terraform {
  required_version = "~>1.3.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"  
      version = "~> 3.0"
    }
  }
}

variable env {
  type        = string
  default     = ""
  description = "environment name"
}

variable bucket_name {
    type = string
    default = ""
    description = "bucket name"
}

resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.env
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}