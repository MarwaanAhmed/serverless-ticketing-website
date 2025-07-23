data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = var.source_directory # e.g., "src/create_ticket"
  output_path = "${path.module}/../../.terraform-build/${var.function_name}.zip" # Output zip to .terraform-build
}

# IAM Role for Lambda Execution
resource "aws_iam_role" "lambda_exec_role" {

  name_prefix = format("%s-%s-role-", var.project_name, var.environment)
  assume_role_policy = jsonencode({
    Version = "2012-10-17",

    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = var.function_name
    Project     = var.project_name
  }
}

# IAM Policy for CloudWatch Logs
resource "aws_iam_role_policy" "lambda_logging_policy" {
  name   = format("%s-logging-policy", var.function_name)
  role   = aws_iam_role.lambda_exec_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Effect   = "Allow",
      Resource = "arn:aws:logs:${var.aws_region}:${var.account_id}:log-group:/aws/lambda/${var.function_name}*"
    }]
  })
}


# IAM Policy for DynamoDB PutItem
resource "aws_iam_role_policy" "dynamodb_write_policy" {
  name   = format("%s-dynamodb-write-policy", var.function_name)
  role   = aws_iam_role.lambda_exec_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "dynamodb:PutItem"
      ],
      Effect   = "Allow",
      Resource = var.dynamodb_table_arn
    }]
  })
}


# The AWS Lambda Function
resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  handler       = var.handler_name 
  runtime       = "python3.9"
  memory_size   = var.memory_size
  timeout       = var.timeout
  role          = aws_iam_role.lambda_exec_role.arn

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }

  tags = {
    Name        = var.function_name
    Environment = var.environment
    Project     = var.project_name
  }
}