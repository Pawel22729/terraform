provider "aws" {
  region = "eu-west-2"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "function.zip"
  function_name    = "pablo_lambda"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "main"
  runtime          = "go1.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
