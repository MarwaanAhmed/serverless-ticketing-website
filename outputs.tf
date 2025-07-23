output "dynamodb_table_name" {
  description = "The name of the DynamoDB tickets table."
  value       = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB tickets table."
  value       = module.dynamodb.table_arn
}

output "dynamodb_table_stream_arn" {
  description = "The ARN of the DynamoDB tickets table stream."
  value       = module.dynamodb.table_stream_arn
}

output "create_ticket_lambda_arn" {
  description = "The ARN of the create_ticket Lambda function."
  value       = module.create_ticket_lambda.function_arn
}

output "create_ticket_lambda_invoke_arn" {
  description = "The Invoke ARN of the create_ticket Lambda function."
  value       = module.create_ticket_lambda.invoke_arn
}