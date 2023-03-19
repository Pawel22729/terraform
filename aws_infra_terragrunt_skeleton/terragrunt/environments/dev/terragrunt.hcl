include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../..//terraform/products/s3_bucket"
}

inputs = {
    bucket_name = "this-is-a-temp-pablo-bucket"
}
