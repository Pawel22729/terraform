variable "public_prefix" {
  type    = string
  default = "static."
}

variable "public_suffix" {
  type    = string
  default = ".com"
}

variable "private_suffix" {
  type    = string
  default = "-img-master"
}

variable "s3_bucket_name" {
  type    = list(string)
  default = ["brand1"]
}
