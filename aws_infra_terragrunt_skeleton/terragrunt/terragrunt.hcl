locals {
    project_name = "project-infra"
    region = "eu-central-1"
    dynamo_path = replace(path_relative_to_include(), "/", "-")
    dirs = split("/", path_relative_to_include())
    env = local.dirs[1]
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "tf-state-pablo"
    key = "${local.project_name}/${path_relative_to_include()}/terraform.tfstate"
    region = local.region
    dynamodb_table = "${local.project_name}-${local.dynamo_path}-terraform-state-lock"
  }
}

inputs = {
    env = local.env
}