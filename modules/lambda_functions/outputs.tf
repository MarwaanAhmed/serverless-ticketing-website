output "function_name" {
  description = "The name of the Lambda function."
  value       = aws_lambda_function.lambda_function.function_name
}

output "function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.lambda_function.arn
}

output "invoke_arn" {
  description = "The ARN to be used for invoking the Lambda function."
  value       = aws_lambda_function.lambda_function.invoke_arn
}

output "lambda_exec_role_arn" {
  description = "The ARN of the IAM role used by the Lambda function."
  value       = aws_iam_role.lambda_exec_role.arn
}