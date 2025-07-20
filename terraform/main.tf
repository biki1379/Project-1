resource "aws_s3_bucket" "data_bucket" {
  bucket = var.bucket_name
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_lambda_function" "data_processor" {
  filename         = "../lambda/lambda_function.zip"
  function_name    = "dataProcessorFunction"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("../lambda/lambda_function.zip")
  runtime          = "python3.9"
}

