output "table_name" {
  description = "The name of the created DynamoDB table."
  value       = aws_dynamodb_table.tickets_table.name
}

output "table_arn" {
  description = "The ARN of the created DynamoDB table."
  value       = aws_dynamodb_table.tickets_table.arn
}

output "table_stream_arn" {
  description = "The ARN of the DynamoDB stream for the table."
  value       = aws_dynamodb_table.tickets_table.stream_arn
}
