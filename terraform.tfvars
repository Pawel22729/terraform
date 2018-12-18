terragrunt = {
  remote_state {
    backend = "s3" 
    config {
      bucket		= "plasak-bucket-state"
      key		= "${path_relative_to_include()}/terraform.tfstate"
      region		= "eu-west-2"
      dynamodb_table	= "plasak-state-table"
    }
  }
  
  terraform {
    source = ".//createBucket/"
  }
}
